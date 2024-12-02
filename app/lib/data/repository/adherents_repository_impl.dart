
import 'package:injectable/injectable.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/adherents.dart';
import 'adherents_repository.dart';

@injectable
class AdherentsRepositoryImpl extends AdherentsRepository {
final  FirestoreService _firestoreService;

   AdherentsRepositoryImpl(this._firestoreService);


@override
Stream<Iterable<Adherents>> getAdherentsStream() {
  return _firestoreService.collection('adherents').snapshots().map(
        (querySnapshot) => querySnapshot.docs
        .map((doc) => Adherents.fromMap(doc.data(), doc.id))
        .toList(),
  );
}

@override
Future<Map<String, dynamic>?> getById(String adherentsId) {
  return _firestoreService
      .collection('adherents')
      .doc(adherentsId)
      .get()
      .then((docSnapshot) => docSnapshot.data());
}

@override
Future<void> add(Map<String, dynamic> data) async {
  try {
    await _firestoreService.collection('adherents').add(data);
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
    await _firestoreService.collection('adherents').doc(adherentId).update({
      fieldName: newValue,
    });
  } catch (e) {
    // Gestion des erreurs
    debugPrint('Error updating field: $e');
    rethrow;
  }
}

}