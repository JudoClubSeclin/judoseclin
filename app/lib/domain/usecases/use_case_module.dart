
import 'package:get_it/get_it.dart';
import 'package:judoseclin/data/repository/adherents_repository_impl.dart';
import 'package:judoseclin/domain/usecases/fetch_adherents_data_usecase.dart';

final GetIt getIt = GetIt.instance;

void setupDataUseCaseModule() {
  getIt.registerLazySingleton<FetchAdherentsDataUseCase>(() => FetchAdherentsDataUseCase(getIt<AdherentsRepositoryImpl>()));


}