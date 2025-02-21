import 'package:get_it/get_it.dart';

import '../../data/repository/user_repository/user_data_repository.dart';
import 'account_interactor.dart';

final getIt = GetIt.instance;

void setupAccountModule() {
  if (!getIt.isRegistered<AccountInteractor>()) {
    getIt.registerLazySingleton(() => AccountInteractor(getIt<UserDataRepository>()));
  }}


