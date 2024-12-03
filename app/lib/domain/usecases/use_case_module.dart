import 'package:get_it/get_it.dart';
import 'package:judoseclin/data/repository/user_repository/auth_state_repository.dart';
import 'package:judoseclin/data/repository/user_repository/user_data_repository.dart';
import 'package:judoseclin/domain/usecases/fetch_adherents_data_usecase.dart';
import 'package:judoseclin/domain/usecases/fetch_cotisation_data_usecase.dart';
import 'package:judoseclin/domain/usecases/fetch_inscription_competition_data_usecase.dart';
import 'package:judoseclin/domain/usecases/fetch_user_data_usecase.dart';

import 'fetch_competitions_data_usecase.dart';

final GetIt getIt = GetIt.instance;

void setupDataUseCaseModule() {
  getIt.registerLazySingleton<FetchAdherentsDataUseCase>(
      () => FetchAdherentsDataUseCase());

  getIt.registerLazySingleton<FetchCompetitionDataUseCase>(
      () => FetchCompetitionDataUseCase());

  getIt.registerLazySingleton<FetchCotisationDataUseCase>(
      () => FetchCotisationDataUseCase());

  getIt.registerLazySingleton<FetchInscriptionCompetitionDataUseCase>(
      () => FetchInscriptionCompetitionDataUseCase());

  getIt.registerLazySingleton<FetchUserDataUseCase>(() => FetchUserDataUseCase(
      getIt<UserDataRepository>(), getIt<AuthStateRepository>()));
}
