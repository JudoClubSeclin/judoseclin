import 'package:flutter/cupertino.dart';

import '../../../../../domain/entities/competition.dart';
import '../../../../../domain/usecases/competitions/fetch_competitions_data_usecase.dart';
import '../../competition_repository/competition_repository.dart';

class AddCompetitionInteractor {
  final FetchCompetitionDataUseCase fetchCompetitionDataUseCase;
  final CompetitionRepository competitionRepository;

  AddCompetitionInteractor(
      this.fetchCompetitionDataUseCase, this.competitionRepository);

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

  Future<Competition?> getCompetitionById(competitionId) async {
    try {
      return await fetchCompetitionDataUseCase
          .getCompetitionById(competitionId);
    } catch (e) {
      debugPrint(
          'Erreur lors de la récupération de la compétition par ID : $e');
      rethrow;
    }
  }

  Future<void> updateCompetitionField({
    required String competitionId,
    required String fieldName,
    required String newValue,
  }) async {
    try {
      await competitionRepository.updateField(
          competitionId, fieldName, newValue);
    } catch (error) {
      debugPrint('Erreur lors de la mise à jour du champ : $error');
      rethrow;
    }
  }
}
