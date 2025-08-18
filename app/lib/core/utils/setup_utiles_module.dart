import 'package:get_it/get_it.dart';
import 'package:judoseclin/core/utils/competition_provider.dart';

import 'competition_registration_provider.dart';

final getIt = GetIt.instance;

void setupUtilsModule() {
  if (!getIt.isRegistered<CompetitionProvider>()) {
    getIt.registerLazySingleton(
          () => CompetitionProvider(),
    );
  }

  if (!getIt.isRegistered<CompetitionRegistrationProvider>()) {
    getIt.registerLazySingleton(
          () => CompetitionRegistrationProvider(),
    );
  }




}
