// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/repository/user_repository/auth_user.dart' as _i4;
import 'data/repository/user_repository/user_info.dart' as _i3;
import 'data/repository/user_repository/user_is_connected.dart' as _i5;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.UserInfoRepository>(() => _i3.UserInfoRepositoryImpl());
    gh.singleton<_i4.AuthUserRepository>(() => _i4.AuthUserRepositoryImpl());
    gh.singleton<_i5.UserIsConnectedRepository>(
        () => _i5.UserIsConnectedRepositoryImpl());
    return this;
  }
}
