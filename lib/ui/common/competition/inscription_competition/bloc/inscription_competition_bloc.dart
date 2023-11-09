import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/competition/inscription_competition/bloc/inscription_competition_state.dart';

import '../../../../../domain/entities/inscription_competition.dart';
import 'inscription_competition_event.dart';

class InscriptionCompetitionBloc
    extends Bloc<InscriptionCompetitionEvent, InscriptionCompetitionState> {
  final FirebaseFirestore _firestore;

  InscriptionCompetitionBloc(this._firestore)
      : super(InscriptionCompetitionInitial());

  Future<void> validateInscription(String inscriptionId) async {
    try {
      await _firestore
          .collection('competition-registration')
          .doc(inscriptionId)
          .update({'validated': true});
      emit(InscriptionCompetitionSuccess());
    } catch (e) {
      emit(InscriptionCompetitionError(e.toString()));
    }
  }

  Future<void> registerForCompetition(
      String userId, String competitionId) async {
    debugPrint('Trying to register for competition');
    emit((InscriptionCompetitionProgress()));

    //Vérification de la periode d'inscription.
    bool canRegister = await _canRegisterForCompetition(competitionId);

    if (!canRegister) {
      emit(InscriptionCompetitionClosed());
      return;
    }
    //Procéder à l'inscription.
    try {
      await _firestore.collection('competition-registration').add({
        'userId': userId,
        'competitionId': competitionId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      emit(InscriptionCompetitionSuccess());
    } catch (e) {
      emit(InscriptionCompetitionError(e.toString()));
    }
  }

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
          'Required fields date or publishDate not found in the document');
    }

    DateTime now = DateTime.now();
    DateTime competitionDate = (data['date'] as Timestamp).toDate();
    DateTime publishDate = (data['publishDate'] as Timestamp).toDate();

    //Calculate registration by subtracting 7 day from competitionDate
    DateTime registrationEnd =
        competitionDate.subtract(const Duration(days: 7));

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
      DocumentSnapshot doc = await _firestore
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
      QuerySnapshot querySnapshot = await _firestore
          .collection('competition-registration')
          .where('userId', isEqualTo: userId)
          .get();
      List<String> competitionIds = [];
      for (var doc in querySnapshot.docs) {
        competitionIds.add(doc['competitionId']);
      }
      return competitionIds;
    } catch (e) {
      debugPrint('Erreur lors de la récupération des inscriptions: $e');
      return [];
    }
  }
}
