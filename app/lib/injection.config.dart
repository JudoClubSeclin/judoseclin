// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'data/repository/user_repository/auth_user.dart' as _i1066;
import 'data/repository/user_repository/user_info.dart' as _i207;
import 'data/repository/user_repository/user_is_connected.dart' as _i192;

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
    gh.factory<_i207.UserInfoRepository>(() => _i207.UserInfoRepositoryImpl());
    gh.singleton<_i1066.AuthUserRepository>(
        () => _i1066.AuthUserRepositoryImpl());
    gh.singleton<_i192.UserIsConnectedRepository>(
        () => _i192.UserIsConnectedRepositoryImpl());
    return this;
  }
}
