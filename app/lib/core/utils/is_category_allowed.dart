import 'package:flutter/material.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import '../../ui/competition/inscription_competition/registration_validation.dart';

Future<bool> isCategoryAllowed(
    String userEmail,
    String competitionId,
    FirestoreService firestore,
    ) async {
  try {
    // 1️⃣ Récupérer l'adhérent
    final adherentsSnapshot = await firestore
        .getCollection('adherents')
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get();

    if (adherentsSnapshot.docs.isEmpty) {
      throw Exception("Adhérent non trouvé");
    }

    final adherentData =
    adherentsSnapshot.docs.first.data() as Map<String, dynamic>?;

    if (adherentData == null) {
      throw Exception("Données adhérent incorrectes");
    }

    final category = adherentData['category'] as String?;
    final belt = adherentData['belt'] as String?;

    if (category == null || belt == null) {
      throw Exception("Données adhérent incomplètes");
    }

    // 2️⃣ Récupérer la compétition
    final competitionDoc =
    await firestore.getCollection('competition').doc(competitionId).get();

    if (!competitionDoc.exists) {
      throw Exception("Compétition non trouvée");
    }

    final competitionData = competitionDoc.data() as Map<String, dynamic>?;
    if (competitionData == null) {
      throw Exception("Données de compétition introuvables");
    }

    // 3️⃣ Vérifications
    if (!RegistrationValidation.isBeltValid(belt)) {
      throw Exception("Ceinture invalide");
    }

    if (!RegistrationValidation.isCategoryInCompetition(category, competitionData)) {
      throw Exception("Catégorie non autorisée pour cette compétition");
    }

    debugPrint("✅ L'adhérent peut participer !");
    return true;

  } catch (e) {
    debugPrint("🚨 Erreur vérification catégorie : $e");
    return false;
  }
}
