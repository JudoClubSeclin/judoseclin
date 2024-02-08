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
}
