import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../entities/competition.dart';

class FetchCompetitionDataUseCase {
  final firestore = FirebaseFirestore.instance;

  Future<List<Competition>> getCompetition() async {
    try {
      debugPrint("Fetching competition data from Firestore...");

      QuerySnapshot snapshot = await firestore.collection('competitions').get();
      debugPrint("Competition data fetched successfully.");

      List<Competition> competitions = snapshot.docs
          .map((doc) => Competition.fromFirestore(doc as Map<String, dynamic>))
          .toList();
      return competitions; // Renvoyez les données de la compétition
    } catch (e) {
      debugPrint(e.toString());
      rethrow; // Lancez l'erreur pour que la partie appelante puisse la gérer
    }
  }
}
