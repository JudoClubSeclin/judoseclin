import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/inscription_competition.dart';
import '../../../domain/entities/competition.dart';
import 'inscription_competition_event.dart';
import 'inscription_competition_state.dart';

class InscriptionCompetitionBloc
    extends Bloc<InscriptionCompetitionEvent, InscriptionCompetitionState> {
  final FirebaseFirestore _firestore;

  InscriptionCompetitionBloc(this._firestore)
    : super(InscriptionCompetitionInitial()) {
    on<LoadInscriptionCompetition>(_loadInscriptionCompetition);
    on<ValidationInscription>(_validationInscription);
    on<RegisterForCompetition>(_registerForCompetition);
    on<InscriptionCompetitionSuccess>(_inscriptionCompetitionSuccess);
    on<LoadUserInscriptions>(_loadUserInscriptions);
  }

  void setContext(BuildContext context) {
    context = context;
  }

  Future<void> validateInscription(String inscriptionId) async {
    try {
      await _firestore
          .collection('competition-registration')
          .doc(inscriptionId)
          .update({'validated': true});
      (InscriptionCompetitionSuccess());
    } catch (e) {
      (InscriptionCompetitionError(e.toString()));
    }
  }

  Future<void> registerForCompetition(
    String userId,
    String competitionId,
  ) async {}

  Future<bool> _canRegisterForCompetition(String competitionId) async {
    DocumentSnapshot competitionDoc =
        await _firestore.collection('competition').doc(competitionId).get();

    if (!competitionDoc.exists) {
      throw Exception('Document no found');
    }

    final Map<String, dynamic> data =
        competitionDoc.data() as Map<String, dynamic>;

    if (!data.containsKey('date') || !data.containsKey('publishDate')) {
      throw Exception(
        'Required fields date or publishDate not found in the document',
      );
    }

    DateTime now = DateTime.now();
    DateTime competitionDate = (data['date'] as Timestamp).toDate();
    DateTime publishDate = (data['publishDate'] as Timestamp).toDate();

    //Calculate registration by subtracting 7 day from competitionDate
    DateTime registrationEnd = competitionDate.subtract(
      const Duration(days: 2),
    );

    //For registrationStart, let's consider it as the moment when the competition was published.
    DateTime registrationStart = publishDate;

    debugPrint("Now: $now");
    debugPrint('Registration Start: $registrationStart');
    debugPrint('registration end: $registrationEnd');
    debugPrint('Competition Date: $competitionDate');

    return now.isAfter(registrationStart) && now.isBefore(registrationEnd);
  }

  Future<InscriptionCompetition?> getInscription(String inscriptionId) async {
    try {
      DocumentSnapshot doc =
          await _firestore
              .collection('competition-registration')
              .doc(inscriptionId)
              .get();
      return InscriptionCompetition.fromFirestore(doc);
    } catch (e) {
      debugPrint('Erreur lors de la recuperation de l\'inscription: $e');
      return null;
    }
  }

  Future<List<String>> getInscriptionForUser(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore
              .collection('competition-registration')
              .where('userId', isEqualTo: userId)
              .get();
      // Utilisez un Set pour éliminer les doublons
      Set<String> competitionIds = {};
      for (var doc in querySnapshot.docs) {
        competitionIds.add(doc['competitionId']);
      }
      return competitionIds.toList();
    } catch (e) {
      debugPrint('Erreur lors de la récupération des inscriptions: $e');
      return [];
    }
  }

  FutureOr<void> _loadInscriptionCompetition(
    LoadInscriptionCompetition event,
    Emitter<InscriptionCompetitionState> emit,
  ) {}

  FutureOr<void> _validationInscription(
    ValidationInscription event,
    Emitter<InscriptionCompetitionState> emit,
  ) async {
    try {
      await _firestore
          .collection('competition-registration')
          .doc(event.id)
          .update({'validated': true});
      InscriptionCompetitionSuccess();
    } catch (e) {
      emit(InscriptionCompetitionError(e.toString()));
    }
  }

  FutureOr<void> _registerForCompetition(
    RegisterForCompetition event,
    Emitter<InscriptionCompetitionState> emit,
  ) async {
    debugPrint('Trying to register for competition');
    emit((InscriptionCompetitionProgress()));

    //Vérification de la periode d'inscription.
    bool canRegister = await _canRegisterForCompetition(event.competitionId);

    if (!canRegister) {
      emit(InscriptionCompetitionClosed());
      return;
    }
    //Procéder à l'inscription.
    try {
      await _firestore.collection('competition-registration').add({
        'userId': event.userId,
        'competitionId': event.competitionId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      InscriptionCompetitionSuccess();
    } catch (e) {
      emit(InscriptionCompetitionError(e.toString()));
    }
  }

  FutureOr<void> _inscriptionCompetitionSuccess(
    InscriptionCompetitionSuccess event,
    Emitter<InscriptionCompetitionState> emit,
  ) {
    // Émettre l'état de succès
    emit(InscriptionCompetitionSuccessState());
  }

  Future<List<String>> getUserCompetitionIds(String userId) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore
              .collection('competition-registration')
              .where('userId', isEqualTo: userId)
              .get();
      List<String> competitionIds = [];
      for (var doc in querySnapshot.docs) {
        competitionIds.add(doc['competitionId']);
      }
      // Utilisons un Set pour éliminer les doublons
      return competitionIds.toSet().toList();
    } catch (e) {
      debugPrint('Erreur lors de la récupération des inscriptions: $e');
      return [];
    }
  }

  Future<List<Competition>> getCompetitionsDetails(
    List<String> competitionIds,
  ) async {
    try {
      List<Competition> competitions = [];
      for (String id in competitionIds) {
        DocumentSnapshot competitionDoc =
            await _firestore.collection('competition').doc(id).get();
        if (competitionDoc.exists) {
          competitions.add(
            Competition.fromMap(
              competitionDoc.data() as Map<String, dynamic>,
              competitionDoc.id,
            ),
          );
        }
      }
      return competitions;
    } catch (e) {
      debugPrint(
        'Erreur lors de la récupération des détails des compétitions: $e',
      );
      return [];
    }
  }

  FutureOr<void> _loadUserInscriptions(
    LoadUserInscriptions event,
    Emitter<InscriptionCompetitionState> emit,
  ) async {
    emit(InscriptionCompetitionLoading());
    try {
      final competitionIds = await getInscriptionForUser(event.userId);
      final competitions = await getCompetitionsDetails(competitionIds);
      // Utilisez un Set pour éliminer les doublons
      final uniqueCompetitions = competitions.toSet().toList();
      emit(InscriptionCompetitionLoaded(uniqueCompetitions));
    } catch (e) {
      emit(InscriptionCompetitionError(e.toString()));
    }
  }
}
