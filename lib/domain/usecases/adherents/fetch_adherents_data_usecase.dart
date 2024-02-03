import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/ui/common/adherents/adherents_repository/adherents_repository.dart';

class FetchAdherentsDataUseCase {
  final AdherentsRepository adherentsRepository;

  FetchAdherentsDataUseCase(this.adherentsRepository);

  Future<Iterable<Adherents>> getAdherents() async {
    try {
      debugPrint('Fetching adherents data from Firestore');
      Stream<QuerySnapshot> snapshotStream =
          adherentsRepository.getAdherentsStream();

      QuerySnapshot snapshot = await snapshotStream.first;

      List<Adherents> adherents = snapshot.docs
          .map((doc) => Adherents.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();

      debugPrint('Adherents data fetch successfully');
      return adherents;
    } catch (e) {
      debugPrint(e.toString());
      // Ajoutez un retour explicite en cas d'erreur
      return []; // ou return null; selon votre logique
    }
  }

  Future<Adherents?> getAdherentsById(String adherentsId) async {
    try {
      debugPrint("Fetching adherents data from Firestore...");

      DocumentSnapshot<Object?> adherentsSnapshot =
          await adherentsRepository.getById(adherentsId);
      // Utiliser la méthode fromFirestore pour créer une instance Adherents
      Adherents? adherents = adherentsSnapshot.exists
          ? Adherents.fromFirestore(
              adherentsSnapshot as DocumentSnapshot<Map<String, dynamic>>)
          : null;

      return adherents;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
