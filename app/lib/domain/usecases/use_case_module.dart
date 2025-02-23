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
  if (!getIt.isRegistered<FetchAdherentsDataUseCase>()) {
    getIt.registerLazySingleton<FetchAdherentsDataUseCase>(
      () => FetchAdherentsDataUseCase(),
    );
  }

  if (!getIt.isRegistered<FetchCompetitionDataUseCase>()) {
    getIt.registerLazySingleton<FetchCompetitionDataUseCase>(
      () => FetchCompetitionDataUseCase(),
    );
  }
  if (!getIt.isRegistered<FetchCotisationDataUseCase>()) {
    getIt.registerLazySingleton<FetchCotisationDataUseCase>(
      () => FetchCotisationDataUseCase(),
    );
  }

  if (!getIt.isRegistered<FetchInscriptionCompetitionDataUseCase>()) {
    getIt.registerLazySingleton<FetchInscriptionCompetitionDataUseCase>(
      () => FetchInscriptionCompetitionDataUseCase(),
    );
  }

  if (!getIt.isRegistered<FetchUserDataUseCase>()) {
    getIt.registerLazySingleton<FetchUserDataUseCase>(
      () => FetchUserDataUseCase(
        getIt<UserDataRepository>(),
        getIt<AuthStateRepository>(),
      ),
    );
  }
}
