import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../entities/competition.dart';

class FetchAddCompetitionDataUseCase {
  final firestore = FirebaseFirestore.instance;

  Future<List<Competition>> getCompetition() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('competition').get();

      List<Competition> competition = snapshot.docs
          .map((doc) => Competition.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
      return competition;
    } catch (e) {
      debugPrint('Erreur lors de la récupération des compétitions : $e');
      rethrow;
    }
  }

  Future<Competition?> getCompetitionById(String competitionId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> competitionSnapshot =
          await firestore.collection('competition').doc(competitionId).get();

      if (competitionSnapshot.exists) {
        return Competition.fromFirestore(competitionSnapshot);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(
          'Erreur lors de la récupération de la compétition par ID : $e');
      rethrow;
    }
  }
}
