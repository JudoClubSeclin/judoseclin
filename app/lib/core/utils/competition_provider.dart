import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class CompetitionProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Récupérer les compétitions passées pour un adhérent
  Future<List<Map<String, dynamic>>> getPastCompetitionsForAdherent(String adherentId) async {
    try {
      final registrations = await _firestore
          .collection('competition_registration')
          .where('adherentId', isEqualTo: adherentId)
          .get();

      List<Map<String, dynamic>> pastCompetitions = [];

      for (var doc in registrations.docs) {
        final data = doc.data();
        final compId = data['competitionId'];

        // Charger la compétition liée
        final compDoc = await _firestore.collection('competitions').doc(compId).get();
        if (compDoc.exists) {
          final compData = compDoc.data()!;
          final compDate = (compData['date'] as Timestamp).toDate();

          if (compDate.isBefore(DateTime.now())) {
            pastCompetitions.add({
              'id': compDoc.id,
              'title': compData['title'],
              'date': compDate,
            });
          }
        }
      }

      return pastCompetitions;
    } catch (e) {
      debugPrint("Erreur récupération compétitions passées : $e");
      return [];
    }
  }

  Future<Map<String, dynamic>?> getCompetitionById(String competitionId) async {
    try {
      final doc = await _firestore.collection('competitions').doc(competitionId).get();
      if (doc.exists) {
        final data = doc.data()!;
        final compDate = (data['date'] as Timestamp).toDate();
        return {
          'id': doc.id,
          'title': data['title'] ?? 'Compétition',
          'date': compDate,
        };
      }
      return null;
    } catch (e) {
      debugPrint("Erreur getCompetitionById: $e");
      return null;
    }
  }

}
