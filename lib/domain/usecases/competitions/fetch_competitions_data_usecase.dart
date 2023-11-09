import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../entities/competition.dart';

class FetchCompetitionDataUseCase {
  final firestore = FirebaseFirestore.instance;

  Future<List<Competition>> getCompetition() async {
    try {
      debugPrint("Fetching competition data from Firestore...");

      QuerySnapshot snapshot = await firestore.collection('competition').get();
      debugPrint("Competition data fetched successfully.");

      List<Competition> competition = snapshot.docs
          .map((doc) => Competition.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
      return competition; // Renvoyez les données de la compétition
    } catch (e) {
      debugPrint(e.toString());
      rethrow; // Lancez l'erreur pour que la partie appelante puisse la gérer
    }
  }

  Future<Competition?> getCompetitionById(String competitionId) async {
    try {
      debugPrint("Fetching competition data from Firestore...");

      // Utilisez le .doc(competitionId) pour récupérer une compétition spécifique par son ID
      DocumentSnapshot<Map<String, dynamic>> competitionSnapshot =
          await firestore.collection('competition').doc(competitionId).get();

      if (competitionSnapshot.exists) {
        // Si la compétition existe, créez une instance de Competition à partir des données
        Competition competition =
            Competition.fromFirestore(competitionSnapshot);

        return competition;
      } else {
        // La compétition n'existe pas
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
