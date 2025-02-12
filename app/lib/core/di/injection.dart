// configure_dependencies.dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../data/repository/repository_module.dart';
import '../../domain/domain_module.dart';
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

  setupUserModule();

  setupAccountModule();

  setupCompetitionModule();

  setupAdminModule();

  setupDomainModule();
}
