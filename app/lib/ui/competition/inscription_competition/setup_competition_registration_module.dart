import 'package:get_it/get_it.dart';
import 'package:judoseclin/domain/usecases/fetch_competition_registration_data_usecase.dart';
import 'package:judoseclin/ui/competition/inscription_competition/competition_registration_bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/di/api/firestore_service.dart';
import '../../../data/repository/competition_registration_repository.dart';
import '../../../domain/usecases/fetch_adherents_data_usecase.dart';
import 'competition_registration_interactor.dart';


final getIt = GetIt.instance;

void setupCompetitionRegistrationModule() {
  debugPrint("setupCompetitionRegistrationModule appelé");

  // Diagnostic rapide pour voir ce qui manque
  debugPrint("RegisterToCompetitionUseCase registered ? ${getIt.isRegistered<RegisterToCompetitionUseCase>()}");
  debugPrint("GetAdherentRegistrationsUseCase registered ? ${getIt.isRegistered<GetAdherentRegistrationsUseCase>()}");
  debugPrint("CompetitionRegistrationRepository registered ? ${getIt.isRegistered<CompetitionRegistrationRepository>()}");
  debugPrint("FirestoreService registered ? ${getIt.isRegistered<FirestoreService>()}");

  if (!getIt.isRegistered<CompetitionRegistrationBloc>()) {
    getIt.registerFactory<CompetitionRegistrationBloc>(
          () =>
          CompetitionRegistrationBloc(
              getIt<CompetitionRegistrationInteractor>()),
    );
  }

  if (!getIt.isRegistered<CompetitionRegistrationInteractor>()) {
    getIt.registerLazySingleton<CompetitionRegistrationInteractor>(
          () =>
          CompetitionRegistrationInteractor(
              getIt<RegisterToCompetitionUseCase>(),
              getIt<FetchAdherentsDataUseCase>(),
              getIt<CompetitionRegistrationRepository>(),
              getIt<FirestoreService>()),
    );
  }

}


