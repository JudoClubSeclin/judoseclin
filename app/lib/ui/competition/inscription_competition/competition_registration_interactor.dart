import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/domain/usecases/fetch_adherents_data_usecase.dart';

import '../../../data/repository/competition_registration_repository.dart';
import '../../../domain/entities/competition_registration.dart';
import '../../../domain/usecases/fetch_competition_registration_data_usecase.dart';
import 'package:flutter/material.dart';

class CompetitionRegistrationInteractor {
  final RegisterToCompetitionUseCase registerUseCase;
  final FetchAdherentsDataUseCase getUseCase;
  final CompetitionRegistrationRepository repository;
  final FirestoreService firestore;

  CompetitionRegistrationInteractor(this.registerUseCase, this.getUseCase, this.repository, this.firestore);

  Future<void> register(String adherentId, String competitionId, DateTime competitionDate) async {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    if (currentUserId == null) throw Exception("Utilisateur non connecté");

    // 🔍 Récupération de l'adhérent à inscrire
    final adherentDoc = await firestore.collection('adherents').doc(adherentId).get();
    if (!adherentDoc.exists) throw Exception("L'adhérent est introuvable");
    debugPrint("Interactor.register appelé avec adherentId=$adherentId, competitionId=$competitionId");

    final adherentData = adherentDoc.data();
    final String? adherentFamilyId = adherentData?['familyId'];
    if (adherentFamilyId == null) throw Exception("Adhérent sans familyId");

    // ✅ Vérification de la compétition
    final competitionDoc = await firestore.collection('competition').doc(competitionId).get();
    if (!competitionDoc.exists) throw Exception("Compétition introuvable");

    final competitionData = competitionDoc.data()!;
    final DateTime competitionDateFromDB = (competitionData['date'] as Timestamp).toDate();

    if (DateTime.now().isAfter(competitionDateFromDB.subtract(const Duration(days: 2)))) {
      throw Exception("Date limite d'inscription dépassée.");
    }

    // ✅ Inscription
    final registration = CompetitionRegistration(
      id: '',
      adherentId: adherentId,
      competitionId: competitionId,
    );

    await repository.registerToCompetition(registration);
  }



  Future<List<Adherents>> getAdherentRegistrations(String adherentId) {
    return getUseCase.call(adherentId);
  }

  Future<bool> isAdherentRegistered({
    required String adherentId,
    required String competitionId,
  }) async {
    final query = await firestore
        .collection('competition_registration')
        .where('adherentId', isEqualTo: adherentId)
        .where('competitionId', isEqualTo: competitionId)
        .limit(1)
        .get();

    return query.docs.isNotEmpty;
  }
}

