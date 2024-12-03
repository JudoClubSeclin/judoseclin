// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/di/api/auth_service.dart' as _i954;
import 'core/di/api/firebase_client.dart' as _i403;
import 'core/di/api/firestore_service.dart' as _i16;
import 'core/di/api/storage_service.dart' as _i343;
import 'core/di/injection_module.dart' as _i571;
import 'core/router/router_config.dart' as _i1024;
import 'data/repository/adherents_repository_impl.dart' as _i492;
import 'data/repository/competititon_repository_impl.dart' as _i921;
import 'data/repository/user_repository/auth_state_repository.dart' as _i875;
import 'data/repository/user_repository/auth_state_repository_impl.dart'
    as _i604;
import 'data/repository/user_repository/user_auth_repository.dart' as _i909;
import 'data/repository/user_repository/user_auth_repository_impl.dart' as _i26;
import 'data/repository/user_repository/user_data_repository.dart' as _i821;
import 'data/repository/user_repository/user_data_repository_impl.dart'
    as _i354;
import 'domain/usecases/fetch_adherents_data_usecase.dart' as _i775;
import 'domain/usecases/fetch_competitions_data_usecase.dart' as _i108;
import 'domain/usecases/fetch_cotisation_data_usecase.dart' as _i813;
import 'domain/usecases/fetch_inscription_competition_data_usecase.dart'
    as _i82;
import 'domain/usecases/fetch_user_data_usecase.dart' as _i908;
import 'ui/landing/landing_module.dart' as _i112;
import 'ui/ui_module.dart' as _i887;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final injectionModule = _$InjectionModule();
    gh.factory<_i403.FirebaseClient>(() => _i403.FirebaseClient());
    gh.factory<_i813.FetchCotisationDataUseCase>(
        () => _i813.FetchCotisationDataUseCase());
    gh.factory<_i775.FetchAdherentsDataUseCase>(
        () => _i775.FetchAdherentsDataUseCase());
    gh.factory<_i108.FetchCompetitionDataUseCase>(
        () => _i108.FetchCompetitionDataUseCase());
    gh.factory<_i82.FetchInscriptionCompetitionDataUseCase>(
        () => _i82.FetchInscriptionCompetitionDataUseCase());
    gh.singleton<_i887.AppRouter>(() => _i887.AppRouter());
    gh.singleton<_i59.FirebaseAuth>(() => injectionModule.firebaseAuth);
    gh.singleton<_i457.FirebaseStorage>(() => injectionModule.firebaseStorage);
    gh.singleton<_i974.FirebaseFirestore>(
        () => injectionModule.firebaseFireStore);
    gh.singleton<_i1024.AppRouterConfig>(() => _i1024.AppRouterConfig());
    gh.factory<_i821.UserDataRepository>(() => _i354.UserDataRepositoryImpl());
    gh.singleton<_i909.UserAuthRepository>(() => _i26.UserAuthRepositoryImpl());
    gh.factory<_i875.AuthStateRepository>(
        () => _i604.AuthStateRepositoryImpl());
    gh.lazySingleton<_i954.AuthService>(
        () => _i954.AuthService(gh<_i59.FirebaseAuth>()));
    gh.factory<_i16.FirestoreService>(
        () => _i16.FirestoreService(gh<_i974.FirebaseFirestore>()));
    gh.singleton<_i112.LandingModule>(
        () => _i112.LandingModule(gh<_i887.AppRouter>()));
    gh.factory<_i921.CompetitionRepositoryImpl>(
        () => _i921.CompetitionRepositoryImpl(gh<_i16.FirestoreService>()));
    gh.factory<_i492.AdherentsRepositoryImpl>(
        () => _i492.AdherentsRepositoryImpl(gh<_i16.FirestoreService>()));
    gh.factory<_i908.FetchUserDataUseCase>(() => _i908.FetchUserDataUseCase(
          gh<_i821.UserDataRepository>(),
          gh<_i875.AuthStateRepository>(),
        ));
    gh.factory<_i343.StorageService>(
        () => _i343.StorageService(gh<_i457.FirebaseStorage>()));
    return this;
  }
}

class _$InjectionModule extends _i571.InjectionModule {}
