import 'package:judoseclin/domain/usecases/competitions/fetch_competitions_data_usecase.dart';

import '../../../../../domain/entities/competition.dart';

class CompetitionInteractor {
  final FetchCompetitionDataUseCase fetchCompetitionDataUseCase;

  CompetitionInteractor(this.fetchCompetitionDataUseCase);

  Future<List<Competition>> fetchCompetitionData() async {
    try {
      return await fetchCompetitionDataUseCase.getCompetition();
    } catch (e) {
      rethrow;
    }
  }
}
