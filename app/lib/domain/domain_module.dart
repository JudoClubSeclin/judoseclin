import 'package:judoseclin/domain/entities/setup_entity_module.dart';
import 'package:judoseclin/domain/usecases/use_case_module.dart';

void setupDomainModule() {
  setupDataUseCaseModule();
  setupEntityModule();
}
