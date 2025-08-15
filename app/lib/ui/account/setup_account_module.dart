import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:judoseclin/core/di/api/auth_service.dart';
import 'package:judoseclin/ui/account/account_bloc.dart';
import 'package:judoseclin/ui/account/adherents_session.dart';
import '../../core/di/api/firestore_service.dart';
import '../../data/repository/user_repository/user_data_repository.dart';
import 'account_interactor.dart';

final getIt = GetIt.instance;

void setupAccountModule() {
  if (!getIt.isRegistered<AccountInteractor>()) {
    getIt.registerLazySingleton(
          () => AccountInteractor(getIt<UserDataRepository>()),
    );
  }

  if (!getIt.isRegistered<AccountBloc>()) {
    getIt.registerLazySingleton(() => AccountBloc(
      accountInteractor: getIt<AccountInteractor>(),
      firestore: getIt<FirestoreService>(),
      auth: getIt<AuthService>(),
    ));
  }

  if (!getIt.isRegistered<AdherentSession>()) {
    getIt.registerLazySingleton<AdherentSession>(() => AdherentSession());
  }


}
