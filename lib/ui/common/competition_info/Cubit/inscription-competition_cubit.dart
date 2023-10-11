import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/inscription_competition.dart';

abstract class InscriptionCompetitionState {}

class InscriptionCompetitionInitial extends InscriptionCompetitionState {}

class InscriptionCompetitionProgress extends InscriptionCompetitionState {}

class InscriptionCompetitionSuccess extends InscriptionCompetitionState {}

class InscriptionCompetitionFailure extends InscriptionCompetitionState {
  final String errorMessage;

  InscriptionCompetitionFailure(this.errorMessage);
}

class InscriptionCompetitionClosed extends InscriptionCompetitionState {}

class InscriptionCompetitionCubit extends Cubit<InscriptionCompetitionState> {
  final FirebaseFirestore _firestore;

  InscriptionCompetitionCubit(this._firestore)
      : super(InscriptionCompetitionInitial());

  Future<void> registerForCompetition(
      String userId, String competitionId) async {
    emit(InscriptionCompetitionProgress());

    // Vérification de la période d'inscription.
    bool canRegister = await _canRegisterForCompetition(competitionId);

    if (!canRegister) {
      emit(InscriptionCompetitionClosed());
      return;
    }

    // Procéder à l'inscription.
    try {
      await _firestore.collection('inscription-competition').add({
        'userId': userId,
        'competitionId': competitionId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      emit(InscriptionCompetitionSuccess());
    } catch (e) {
      emit(InscriptionCompetitionFailure(e.toString()));
    }
  }

  Future<bool> _canRegisterForCompetition(String competitionId) async {
    DocumentSnapshot competitionDoc =
        await _firestore.collection('competition').doc(competitionId).get();

    if (!competitionDoc.exists) {
      throw Exception('Document not found');
    }

    final Map<String, dynamic> data =
        competitionDoc.data() as Map<String, dynamic>;

    if (!data.containsKey('date')) {
      throw Exception('Required field date not found in the document');
    }

    DateTime now = DateTime.now();
    DateTime competitionDate = (data['date'] as Timestamp).toDate();

    // Calculate registrationEnd by subtracting 24 hours from competitionDate
    DateTime registrationEnd =
        competitionDate.subtract(const Duration(hours: 24));

    // For registrationStart, let's consider it as the moment when the competition was created.
    // For this example, let's consider it as 1 week before the competitionDate.
    DateTime registrationStart =
        competitionDate.subtract(const Duration(days: 7));

    return now.isAfter(registrationStart) && now.isBefore(registrationEnd);
  }

  Future<InscriptionCompetition?> getInscription(String inscriptionId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('inscription-competition')
          .doc(inscriptionId)
          .get();
      return InscriptionCompetition.fromFirestore(doc);
    } catch (e) {
      debugPrint("Erreur lors de la récupération de l'inscription: $e");
      return null;
    }
  }
}
