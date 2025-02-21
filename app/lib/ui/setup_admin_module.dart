import 'package:judoseclin/core/di/injection.dart';
import 'package:judoseclin/data/repository/adherents_repository_impl.dart';
import 'package:judoseclin/domain/usecases/fetch_adherents_data_usecase.dart';
import 'package:judoseclin/ui/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/cotisations/interactor/cotisation_interactor.dart';

import '../data/repository/cotisation_repository.dart';
import '../domain/usecases/fetch_cotisation_data_usecase.dart';

void setupAdminModule() {
  getIt.registerFactory(() => AdherentsInteractor(
      getIt<FetchAdherentsDataUseCase>(), getIt<AdherentsRepositoryImpl>()));
  getIt.registerFactory(() => CotisationInteractor(
      getIt<FetchCotisationDataUseCase>(), getIt<CotisationRepository>()));
}
