import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:flutter/material.dart';



Future<bool> isCategoryAllowed(String userEmail, String competitionId, FirestoreService firestore) async {
  try {
    // 🔍 Recherche l'adhérent correspondant à l'email
    final adherentsSnapshot = await firestore.getCollection('adherents')
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get();

    if (adherentsSnapshot.docs.isEmpty) {
      debugPrint("❌ Adhérent non trouvé pour l'email : $userEmail");
      throw Exception("Adhérent non trouvé");
    }

    // ✅ Récupération des données sous forme de Map<String, dynamic>
    final adherentData = adherentsSnapshot.docs.first.data() as Map<String, dynamic>?;

    if (adherentData == null || !adherentData.containsKey('category')) {
      debugPrint("❌ Données adhérent incorrectes ou catégorie absente");
      throw Exception("Données adhérent incorrectes");
    }

    final adherentCategory = adherentData['category'];

    // 🔍 Récupération des données de la compétition
    final competitionDoc = await firestore.getCollection('competition').doc(competitionId).get();

    if (!competitionDoc.exists) {
      debugPrint("❌ Compétition non trouvée pour ID : $competitionId");
      throw Exception("Compétition non trouvée");
    }

    // ✅ Vérification des données de la compétition
    final competitionData = competitionDoc.data() as Map<String, dynamic>?;

    if (competitionData == null) {
      throw Exception("Données de la compétition introuvables");
    }

    // ✅ Vérification que la catégorie de l'adhérent existe bien dans la compétition
    if (competitionData.containsKey(adherentCategory) && competitionData[adherentCategory] != null) {
      debugPrint("✅ L'adhérent peut participer à la compétition !");
      return true;
    } else {
      debugPrint("❌ Catégorie non autorisée : $adherentCategory");
      throw Exception("Votre catégorie ne fait pas partie de cette compétition");
    }
  } catch (e) {
    debugPrint("🚨 Erreur vérification catégorie : $e");
    return false;
  }
}

