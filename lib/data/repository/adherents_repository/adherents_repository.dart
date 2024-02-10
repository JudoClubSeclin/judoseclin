import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/adherents.dart';

abstract class AdherentsRepository {
  FirebaseFirestore get firestore;

  Stream<Iterable<Adherents>> getAdherentsStream();
  Future<Map<String, dynamic>?> getById(String adherentsId);
  Future<void> add(Map<String, dynamic> data);
  Future<void> updateField(
      String adherentId, String fieldName, String newValue);
}

class ConcreteAdherentsRepository extends AdherentsRepository {
  @override
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<Iterable<Adherents>> getAdherentsStream() {
    return firestore.collection('adherents').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => Adherents.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Future<Map<String, dynamic>?> getById(String adherentsId) {
    return firestore
        .collection('adherents')
        .doc(adherentsId)
        .get()
        .then((docSnapshot) => docSnapshot.data());
  }

  @override
  Future<void> add(Map<String, dynamic> data) async {
    try {
      await firestore.collection('adherents').add(data);
    } catch (e) {
      // Gestion des erreurs
      debugPrint('Error adding adherent: $e');
      rethrow;
    }
  }

  @override
  Future<void> updateField(
      String adherentId, String fieldName, String newValue) async {
    try {
      await firestore.collection('adherents').doc(adherentId).update({
        fieldName: newValue,
      });
    } catch (e) {
      // Gestion des erreurs
      debugPrint('Error updating field: $e');
      rethrow;
    }
  }

  FirebaseFirestore get firestoreInstance => firestore;
}
