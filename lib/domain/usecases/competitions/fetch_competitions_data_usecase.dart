import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:judoseclin/ui/common/competition/competition_repository/competition_repository.dart';

import '../../entities/competition.dart';

class FetchCompetitionDataUseCase {
  final CompetitionRepository competitionRepository;

  FetchCompetitionDataUseCase(this.competitionRepository);

  Future<List<Competition>> getCompetition() async {
    try {
      debugPrint("Fetching competition data from Firestore...");

      Stream<QuerySnapshot> snapshotStream =
          competitionRepository.getCompetitionStream();
      QuerySnapshot snapshot = await snapshotStream.first;
      debugPrint("Competition data fetched successfully.");

      List<Competition> competition = snapshot.docs
          .map((doc) => Competition.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
      return competition; // Renvoyez les données de la compétition
    } catch (e) {
      debugPrint(e.toString());
      rethrow; // Lancez l'erreur pour que la partie appelante puisse la gérer
    }
  }

  Future<Competition?> getCompetitionById(String competitionId) async {
    try {
      debugPrint("Fetching competition data from Firestore...");

      // Utilisez le .doc(competitionId) pour récupérer une compétition spécifique par son ID
      DocumentSnapshot<Object?> competitionSnapshot =
          await competitionRepository.getById(competitionId);
      Competition? competition = competitionSnapshot.exists
          ? Competition.fromFirestore(
              competitionSnapshot as DocumentSnapshot<Map<String, dynamic>>)
          : null;

      return competition;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
