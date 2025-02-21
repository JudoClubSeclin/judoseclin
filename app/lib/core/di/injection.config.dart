// dart format width=80
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

import '../../data/repository/adherents_repository_impl.dart' as _i463;
import '../../data/repository/competititon_repository_impl.dart' as _i1004;
import '../../data/repository/user_repository/auth_state_repository.dart'
    as _i48;
import '../../data/repository/user_repository/auth_state_repository_impl.dart'
    as _i515;
import '../../data/repository/user_repository/user_auth_repository.dart'
    as _i208;
import '../../data/repository/user_repository/user_auth_repository_impl.dart'
    as _i131;
import '../../data/repository/user_repository/user_data_repository.dart'
    as _i94;
import '../../data/repository/user_repository/user_data_repository_impl.dart'
    as _i686;
import '../../domain/usecases/fetch_adherents_data_usecase.dart' as _i155;
import '../../domain/usecases/fetch_competitions_data_usecase.dart' as _i846;
import '../../domain/usecases/fetch_cotisation_data_usecase.dart' as _i23;
import '../../domain/usecases/fetch_inscription_competition_data_usecase.dart'
    as _i680;
import '../../domain/usecases/fetch_user_data_usecase.dart' as _i656;
import '../../ui/account/account_interactor.dart' as _i830;
import '../../ui/account/account_module.dart' as _i692;
import '../../ui/adherents/add_adherents_module.dart' as _i776;
import '../../ui/adherents/adherents-detail/adherents_detail_module.dart'
    as _i10;
import '../../ui/adherents/list_adherents_module.dart' as _i1062;
import '../../ui/competition/add_competition/add_competiton_module.dart'
    as _i944;
import '../../ui/competition/list_competition/detail_competition_module.dart'
    as _i409;
import '../../ui/competition/list_competition/list_competition_module.dart'
    as _i606;
import '../../ui/landing/landing_module.dart' as _i483;
import '../../ui/members/inscription/inscription_module.dart' as _i734;
import '../../ui/members/interactor/users_interactor.dart' as _i497;
import '../../ui/members/login/login_module.dart' as _i63;
import '../../ui/members/reset_password/reset_password_module.dart' as _i878;
import '../../ui/ui_module.dart' as _i573;
import '../router/router_config.dart' as _i718;
import 'api/auth_service.dart' as _i977;
import 'api/firebase_client.dart' as _i703;
import 'api/firestore_service.dart' as _i746;
import 'api/storage_service.dart' as _i717;
import 'injection_module.dart' as _i212;

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
    gh.factory<_i703.FirebaseClient>(() => _i703.FirebaseClient());
    gh.factory<_i846.FetchCompetitionDataUseCase>(
        () => _i846.FetchCompetitionDataUseCase());
    gh.factory<_i155.FetchAdherentsDataUseCase>(
        () => _i155.FetchAdherentsDataUseCase());
    gh.factory<_i23.FetchCotisationDataUseCase>(
        () => _i23.FetchCotisationDataUseCase());
    gh.factory<_i680.FetchInscriptionCompetitionDataUseCase>(
        () => _i680.FetchInscriptionCompetitionDataUseCase());
    gh.singleton<_i573.AppRouter>(() => _i573.AppRouter());
    gh.singleton<_i497.UsersInteractor>(() => _i497.UsersInteractor());
    gh.singleton<_i718.AppRouterConfig>(() => _i718.AppRouterConfig());
    gh.singleton<_i59.FirebaseAuth>(() => injectionModule.firebaseAuth);
    gh.singleton<_i457.FirebaseStorage>(() => injectionModule.firebaseStorage);
    gh.singleton<_i974.FirebaseFirestore>(
        () => injectionModule.firebaseFireStore);
    gh.factory<_i94.UserDataRepository>(() => _i686.UserDataRepositoryImpl());
    gh.singleton<_i208.UserAuthRepository>(
        () => _i131.UserAuthRepositoryImpl());
    gh.factory<_i48.AuthStateRepository>(() => _i515.AuthStateRepositoryImpl());
    gh.singleton<_i830.AccountInteractor>(
        () => _i830.AccountInteractor(gh<_i94.UserDataRepository>()));
    gh.singleton<_i734.InscriptionModule>(() => _i734.InscriptionModule(
          gh<_i573.AppRouter>(),
          gh<_i497.UsersInteractor>(),
        ));
    gh.factory<_i746.FirestoreService>(
        () => _i746.FirestoreService(gh<_i974.FirebaseFirestore>()));
    gh.singleton<_i776.AddAdherentsModule>(
        () => _i776.AddAdherentsModule(gh<_i573.AppRouter>()));
    gh.singleton<_i1062.ListAdherentsModule>(
        () => _i1062.ListAdherentsModule(gh<_i573.AppRouter>()));
    gh.singleton<_i10.AdherentsDetailModule>(
        () => _i10.AdherentsDetailModule(gh<_i573.AppRouter>()));
    gh.singleton<_i606.ListCompetitionModule>(
        () => _i606.ListCompetitionModule(gh<_i573.AppRouter>()));
    gh.singleton<_i409.CompetitionDetailModule>(
        () => _i409.CompetitionDetailModule(gh<_i573.AppRouter>()));
    gh.singleton<_i944.AddCompetitionModule>(
        () => _i944.AddCompetitionModule(gh<_i573.AppRouter>()));
    gh.singleton<_i483.LandingModule>(
        () => _i483.LandingModule(gh<_i573.AppRouter>()));
    gh.singleton<_i878.ResetPasswordModule>(
        () => _i878.ResetPasswordModule(gh<_i573.AppRouter>()));
    gh.singleton<_i63.LoginModule>(
        () => _i63.LoginModule(gh<_i573.AppRouter>()));
    gh.singleton<_i692.AccountModule>(
        () => _i692.AccountModule(gh<_i573.AppRouter>()));
    gh.factory<_i1004.CompetitionRepositoryImpl>(
        () => _i1004.CompetitionRepositoryImpl(gh<_i746.FirestoreService>()));
    gh.factory<_i463.AdherentsRepositoryImpl>(
        () => _i463.AdherentsRepositoryImpl(gh<_i746.FirestoreService>()));
    gh.factory<_i656.FetchUserDataUseCase>(() => _i656.FetchUserDataUseCase(
          gh<_i94.UserDataRepository>(),
          gh<_i48.AuthStateRepository>(),
        ));
    gh.factory<_i717.StorageService>(
        () => _i717.StorageService(gh<_i457.FirebaseStorage>()));
    gh.lazySingleton<_i977.AuthService>(() => _i977.AuthService(
          gh<_i59.FirebaseAuth>(),
          gh<_i746.FirestoreService>(),
        ));
    return this;
  }
}

class _$InjectionModule extends _i212.InjectionModule {}
