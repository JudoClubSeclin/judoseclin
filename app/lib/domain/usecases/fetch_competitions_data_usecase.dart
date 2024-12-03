import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../data/repository/competition_repository.dart';
import '../../injection.dart';
import '../entities/competition.dart';

@injectable
class FetchCompetitionDataUseCase {
  final competitionRepository = getIt<CompetitionRepository>();

  Future<List<Competition>> getCompetition() async {
    try {
      debugPrint("Fetching competition data from Firestore...");
      Stream<Iterable<Competition>> competitionStream =
          competitionRepository.getCompetitionStream();

      // Utilisez 'await for' pour consommer le Stream
      List<Competition> competitionList = [];
      await for (var competitionIterable in competitionStream) {
        competitionList.addAll(competitionIterable);
      }

      return competitionList;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Competition?> getCompetitionById(String competitionId) async {
    try {
      debugPrint("Fetching competition data from Firestore...");
      Map<String, dynamic>? competitionData =
          await competitionRepository.getById(competitionId);

      return Competition.fromMap(competitionData, competitionId);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
