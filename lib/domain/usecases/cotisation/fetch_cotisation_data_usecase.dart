import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';

class FetchCotisationDataUseCase {
  final firestore = FirebaseFirestore.instance;

  Future<Iterable<Cotisation>> getCotisation() async {
    try {
      debugPrint("Fetching cotisation data from Firestore...");

      QuerySnapshot snapshot = await firestore.collection('cotisation').get();
      debugPrint("cotisation data fetched successfully.");

      List<Cotisation> cotisation = snapshot.docs
          .map((doc) => Cotisation.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
      return cotisation;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Cotisation?> getCotisationById(String cotisationId) async {
    try {
      debugPrint("Fetching adherents data from Firestore...");

      DocumentSnapshot<Map<String, dynamic>> cotisationSnapshot =
          await firestore.collection('cotisation').doc(cotisationId).get();

      if (cotisationSnapshot.exists) {
        Cotisation cotisation = Cotisation.fromFirestore(cotisationSnapshot);
        return cotisation;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
