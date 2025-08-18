import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class CompetitionRegistrationProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Vérifie si un adhérent est déjà inscrit à une compétition
  Future<bool> isAdherentRegistered(String competitionId, String adherentId) async {
    try {
      final query = await _firestore
          .collection('competition_registration')
          .where('competitionId', isEqualTo: competitionId)
          .where('adherentId', isEqualTo: adherentId)
          .get();

      return query.docs.isNotEmpty;
    } catch (e) {
      debugPrint("Erreur lors de la vérification d'inscription : $e");
      return false;
    }
  }

  /// Récupère toutes les inscriptions (IDs de compétitions) pour un adhérent
  Future<List<String>> getUserInscriptionsForAdherent(String adherentId) async {
    final query = await FirebaseFirestore.instance
        .collection('competition_registration')
        .where('adherentId', isEqualTo: adherentId)
        .get();

    // 👉 Retourner la vraie liste des competitionId
    return query.docs.map((doc) => doc['competitionId'] as String).toList();
  }


  /// Inscrire un adhérent si pas déjà inscrit
  Future<String> inscrireACompetition(String competitionId, String adherentId) async {
    try {
      final alreadyRegistered = await isAdherentRegistered(competitionId, adherentId);
      if (alreadyRegistered) {
        return "⚠️ Vous êtes déjà inscrit à cette compétition.";
      }

      await _firestore.collection('competition_registration').add({
        'competitionId': competitionId,
        'adherentId': adherentId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return "✅ Inscription réussie !";
    } catch (e) {
      debugPrint("Erreur lors de l'inscription : $e");
      return "❌ Une erreur est survenue.";
    }
  }


}
