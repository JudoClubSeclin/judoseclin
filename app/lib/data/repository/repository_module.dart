

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:judoseclin/data/repository/adherents_repository.dart';
import 'package:judoseclin/data/repository/adherents_repository_impl.dart';
import 'package:judoseclin/data/repository/competition_repository.dart';
import 'package:judoseclin/data/repository/cotisation_repository.dart';
import 'package:judoseclin/data/repository/cotisation_repository_impl.dart';
import 'package:judoseclin/data/repository/competititon_repository_impl.dart';
import 'package:judoseclin/data/repository/user_repository/auth_state_repository.dart';
import 'package:judoseclin/data/repository/user_repository/auth_state_repository_impl.dart';
import 'package:judoseclin/data/repository/user_repository/auth_user_repository.dart';
import 'package:judoseclin/data/repository/user_repository/auth_user_repository_impl.dart';
import 'package:judoseclin/data/repository/user_repository/user_data_repository.dart';
import 'package:judoseclin/data/repository/user_repository/user_data_repository_impl.dart';
import 'package:judoseclin/injection.dart';

import '../../core/di/api/firestore_service.dart';

void setupDataModule() {
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  getIt.registerLazySingleton<FirestoreService>(
          () => FirestoreService(getIt<FirebaseFirestore>()));

  getIt.registerLazySingleton<AuthUserRepository>(() => AuthUserRepositoryImpl(getIt<FirebaseAuth>()));

  getIt.registerLazySingleton<AuthStateRepository>(() => AuthStateRepositoryImpl(getIt<FirebaseAuth>()));

  getIt.registerLazySingleton<UserDataRepository>(() => UserDataRepositoryImpl(getIt<FirebaseFirestore>()));

  getIt.registerLazySingleton<AdherentsRepository>(() => AdherentsRepositoryImpl(getIt<FirestoreService>()));

  getIt.registerLazySingleton<CompetitionRepository>(() => CompetitionRepositoryImpl(getIt<FirestoreService>()));

  getIt.registerLazySingleton<CotisationRepository>(() => CotisationRepositoryImpl(getIt<FirestoreService>()));



}