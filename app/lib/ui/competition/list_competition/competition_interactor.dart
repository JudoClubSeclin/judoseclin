import 'package:flutter/material.dart';
import 'package:judoseclin/domain/usecases/fetch_competitions_data_usecase.dart';

import '../../../../domain/entities/competition.dart';
import '../../../data/repository/competition_repository.dart';

class CompetitionInteractor {
  final FetchCompetitionDataUseCase fetchCompetitionDataUseCase;
  final CompetitionRepository competitionRepository;

  CompetitionInteractor(
    this.fetchCompetitionDataUseCase,
    this.competitionRepository,
  );

  Future<Iterable<Competition>> fetchCompetitionData() async {
    try {
      final competitions = await fetchCompetitionDataUseCase.getCompetition();
      return competitions;
    } catch (e) {
      debugPrint('Erreur lors de la récupération des compétitions : $e');
      rethrow;
    }
  }

  Future<Competition?> getCompetitionById(String competitionId) async {
    try {
      return await fetchCompetitionDataUseCase.getCompetitionById(
        competitionId,
      );
    } catch (e) {
      debugPrint(
        'Erreur lors de la récupération de la compétition par ID : $e',
      );
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
