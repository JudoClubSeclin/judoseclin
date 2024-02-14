import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';

abstract class CotisationRepository {
  FirebaseFirestore get firestore;

  Stream<Iterable<Cotisation>> getCotisationStream();
  Future<Map<String, dynamic>?> getById(String cotisationId);
  Future<void> add(Map<String, dynamic> data, String documentId) async {
    try {
      await firestore.collection('cotisation').doc(documentId).set(data);
    } catch (e) {
      debugPrint(
          'Erreur Firestore lors de l\'enregistrement de la cotisation: $e');
    }
  }

  Future<void> updateField(
      String cotisationId, String fieldName, String newValue);
}

class ConcretedCotisationRepository extends CotisationRepository {
  @override
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> add(Map<String, dynamic> data, String documentId) async {
    try {
      // Utiliser la liste convertie dans la sauvegarde Firestore
      await firestore.collection('cotisation').doc(documentId).set({
        'adherentId': data['adherentId'],
        'amount': data['amount'],
        'date': data['date'],
        'cheques': data['cheque'],
        'bankName': data['bankName'],
      });
    } catch (e) {
      debugPrint(
          'Erreur Firestore lors de l\'enregistrement de la cotisation: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> getById(String cotisationId) {
    return firestore
        .collection('cotisation')
        .doc(cotisationId)
        .get()
        .then((docSnapshot) => docSnapshot.data());
  }

  @override
  Stream<Iterable<Cotisation>> getCotisationStream() {
    return firestore.collection('cotisation').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => Cotisation.fromFMap(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Future<void> updateField(
      String cotisationId, String fieldName, String newValue) async {
    try {
      await firestore.collection('cotisation').doc(cotisationId).update({
        fieldName: newValue,
      });
    } catch (e) {
      rethrow;
    }
  }

  FirebaseFirestore get firestoreInstance => firestore;
}
