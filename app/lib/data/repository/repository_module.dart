

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:judoseclin/data/repository/adherents_repository.dart';
import 'package:judoseclin/data/repository/adherents_repository_impl.dart';
import 'package:judoseclin/data/repository/competition_repository.dart';
import 'package:judoseclin/data/repository/cotisation_repository.dart';
import 'package:judoseclin/data/repository/cotisation_repository_impl.dart';
import 'package:judoseclin/data/repository/repository_competititon_impl.dart';
import 'package:judoseclin/injection.dart';

import '../../core/di/api/firestore_service.dart';

void setupDataModule() {
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  getIt.registerLazySingleton<FirestoreService>(
          () => FirestoreService(getIt<FirebaseFirestore>()));

  getIt.registerLazySingleton<AdherentsRepository>(() => AdherentsRepositoryImpl(getIt<FirestoreService>()));

  getIt.registerLazySingleton<CompetitionRepository>(() => CompetitionRepositoryImpl(getIt<FirestoreService>()));

  getIt.registerLazySingleton<CotisationRepository>(() => CotisationRepositoryImpl(getIt<FirestoreService>()));



}