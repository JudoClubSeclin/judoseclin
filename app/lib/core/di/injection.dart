// configure_dependencies.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/competition/inscription_competition/setup_competition_registration_module.dart';

import '../../data/repository/setup_data_module.dart';
import '../../domain/entities/setup_entity_module.dart';
import '../../domain/usecases/use_case_module.dart';
import '../../ui/account/setup_account_module.dart';
import '../../ui/competition/setup_competition_module.dart';
import '../../ui/members/setup_user_module.dart';
import '../../ui/setup_admin_module.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() {
  getIt.init(); // Initialisation générée par Injectable

  // Appel de la configuration des modules spécifiques

  setupDataModule();

  setupDataUseCaseModule();

  setupEntityModule();

  setupUserModule();

  setupAccountModule();

  setupCompetitionModule();

  setupAdminModule();

  setupCompetitionRegistrationModule();
}
