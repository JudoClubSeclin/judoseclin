import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/adherents.dart';

class FetchAdherentsDataUseCase {
  final firestore = FirebaseFirestore.instance;

  Future<Iterable<Adherents>> getAdherents() async {
    try {
      debugPrint("Fetching adherents data from Firestore...");

      QuerySnapshot snapshot = await firestore.collection('adherents').get();
      debugPrint("Adherents data fetched successfully.");

      Iterable<Adherents> adherents = snapshot.docs
          .map((doc) => Adherents.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
      return adherents;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Adherents?> getAdherentsById(String adherentsId) async {
    try {
      debugPrint("Fetching adherents data from Firestore...");

      DocumentSnapshot<Map<String, dynamic>> adherentsSnapshot =
          await firestore.collection('adherents').doc(adherentsId).get();

      if (adherentsSnapshot.exists) {
        Adherents adherents = Adherents.fromFirestore(adherentsSnapshot);
        return adherents;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
