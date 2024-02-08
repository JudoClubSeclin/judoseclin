import 'package:flutter/material.dart';
import 'package:judoseclin/domain/usecases/competitions/fetch_competitions_data_usecase.dart';
import 'package:judoseclin/ui/common/competition/competition_repository/competition_repository.dart';

import '../../../../../domain/entities/competition.dart';

class CompetitionInteractor {
  final FetchCompetitionDataUseCase fetchCompetitionDataUseCase;
  final CompetitionRepository competitionRepository;

  CompetitionInteractor(
      this.fetchCompetitionDataUseCase, this.competitionRepository);

  Future<List<Competition>> fetchCompetitionData() async {
    try {
      return await fetchCompetitionDataUseCase.getCompetition();
    } catch (e) {
      rethrow;
    }
  }

  Future<Competition?> getCompetitionById(String competitionId) async {
    try {
      return await fetchCompetitionDataUseCase
          .getCompetitionById(competitionId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCompetition(Competition competition) async {
    try {
      await competitionRepository.add({
        'address': competition.address,
        'title': competition.title,
        'subtitle': competition.subtitle,
        'date': competition.date,
        'publishDate': competition.publishDate,
        'poussin': competition.poussin,
        'benjamin': competition.benjamin,
        'minime': competition.minime,
        'cadet': competition.cadet,
        'juniorSenior': competition.juniorSenior,
      });
    } catch (error) {
      debugPrint('Erreur lors de l\'ajout de la compétition : $error');
      rethrow;
    }
  }
}
