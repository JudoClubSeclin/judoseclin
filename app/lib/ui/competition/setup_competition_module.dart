import 'package:judoseclin/data/repository/competititon_repository_impl.dart';
import 'package:judoseclin/ui/competition/inscription_competition/inscription_competition_bloc.dart';
import 'package:judoseclin/ui/competition/list_competition/competition_interactor.dart';
import '../../core/di/injection.dart';
import '../../domain/usecases/fetch_competitions_data_usecase.dart';
import 'list_competition/competition_bloc.dart';

void setupCompetitionModule() {
  getIt.registerFactory(
    () => CompetitionInteractor(
      getIt<FetchCompetitionDataUseCase>(),
      getIt<CompetitionRepositoryImpl>(),
    ),
  );
  getIt.registerFactory(() => CompetitionBloc(getIt(), competitionId: ''));
  getIt.registerFactory(() => InscriptionCompetitionBloc(getIt()));
}
