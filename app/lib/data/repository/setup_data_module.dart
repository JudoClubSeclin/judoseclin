import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:judoseclin/data/repository/adherents_repository.dart';
import 'package:judoseclin/data/repository/adherents_repository_impl.dart';
import 'package:judoseclin/data/repository/competition_repository.dart';
import 'package:judoseclin/data/repository/competition_repository_impl.dart';
import 'package:judoseclin/data/repository/cotisation_repository.dart';
import 'package:judoseclin/data/repository/cotisation_repository_impl.dart';
import 'package:judoseclin/data/repository/news_repository.dart';
import 'package:judoseclin/data/repository/news_repository_impl.dart';
import 'package:judoseclin/data/repository/user_repository/auth_state_repository.dart';
import 'package:judoseclin/data/repository/user_repository/auth_state_repository_impl.dart';
import 'package:judoseclin/data/repository/user_repository/user_auth_repository.dart';
import 'package:judoseclin/data/repository/user_repository/user_auth_repository_impl.dart';
import 'package:judoseclin/data/repository/user_repository/user_data_repository.dart';
import 'package:judoseclin/data/repository/user_repository/user_data_repository_impl.dart';

import '../../core/di/api/firestore_service.dart';
import '../../core/di/injection.dart';
import 'competition_registration_repository.dart';
import 'competition_registration_repository_impl.dart';

void setupDataModule() {
  if (!getIt.isRegistered<FirebaseFirestore>()) {
    getIt.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);
  }

  if (!getIt.isRegistered<FirestoreService>()) {
    getIt.registerLazySingleton<FirestoreService>(
        () => FirestoreService(getIt<FirebaseFirestore>()));
  }

  if (!getIt.isRegistered<UserAuthRepository>()) {
    getIt.registerLazySingleton<UserAuthRepository>(
        () => UserAuthRepositoryImpl());
  }

  if (!getIt.isRegistered<AuthStateRepository>()) {
    getIt.registerLazySingleton<AuthStateRepository>(
        () => AuthStateRepositoryImpl());
  }

  if (!getIt.isRegistered<UserDataRepository>()) {
    getIt.registerLazySingleton<UserDataRepository>(
        () => UserDataRepositoryImpl());
  }

  if (!getIt.isRegistered<AdherentsRepository>()) {
    getIt.registerLazySingleton<AdherentsRepository>(
        () => AdherentsRepositoryImpl(getIt<FirestoreService>()));
  }

  if (!getIt.isRegistered<CompetitionRepository>()) {
    getIt.registerLazySingleton<CompetitionRepository>(
        () => CompetitionRepositoryImpl(getIt<FirestoreService>()));
  }

  if (!getIt.isRegistered<CotisationRepository>()) {
    getIt.registerLazySingleton<CotisationRepository>(
        () => CotisationRepositoryImpl(getIt<FirestoreService>()));
  }

  if(!getIt.isRegistered<NewsRepository>()) {
    getIt.registerLazySingleton<NewsRepository>(
        () => NewsRepositoryImpl(getIt<FirestoreService>()));

  }
  if(!getIt.isRegistered<CompetitionRegistrationRepository>()) {
    getIt.registerLazySingleton<CompetitionRegistrationRepository>(
        () => CompetitionRegistrationRepositoryImpl(getIt<FirestoreService>()));
  }

}
