// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/repository/user_repository/auth_user.dart' as _i3;
import 'data/repository/user_repository/user_info.dart' as _i4;
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
    gh.singleton<_i3.AuthUserRepository>(_i3.AuthUserRepositoryImpl()
        as _i1.FactoryFunc<_i3.AuthUserRepository>);
    gh.factory<_i4.UserInfoRepository>(() => _i4.UserInfoRepositoryImpl());
    gh.singleton<_i5.UserIsConnectedRepository>(
        _i5.UserIsConnectedRepositoryImpl()
            as _i1.FactoryFunc<_i5.UserIsConnectedRepository>);
    return this;
  }
}
