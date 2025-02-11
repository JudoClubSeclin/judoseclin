

import 'package:judoseclin/core/di/injection.dart';
import 'package:judoseclin/data/repository/adherents_repository_impl.dart';
import 'package:judoseclin/domain/usecases/fetch_adherents_data_usecase.dart';
import 'package:judoseclin/ui/adherents/interactor/adherents_interactor.dart';

void setupAdminModule () {

  getIt.registerFactory(() => AdherentsInteractor(getIt<FetchAdherentsDataUseCase>(), getIt<AdherentsRepositoryImpl>()));
}