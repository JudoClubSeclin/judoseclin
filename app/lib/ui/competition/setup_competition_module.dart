import 'package:judoseclin/data/repository/competition_repository_impl.dart';
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
  getIt.registerFactory(() => CompetitionBloc(
    getIt<CompetitionRepositoryImpl>(),
  ));
}
