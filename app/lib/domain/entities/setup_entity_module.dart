import 'package:get_it/get_it.dart';
import 'package:judoseclin/domain/entities/adherents.dart';

final GetIt getIt = GetIt.instance;

void setupEntityModule() {
  getIt.registerLazySingleton<Adherents>(() => Adherents(
        id: '',
        firstName: '',
        lastName: '',
        email: '',
        licence: '',
        belt: '',
        discipline: '',
        category: '',
        tutor: '',
        phone: '',
        address: '',
        image: '',
        sante: '',
        medicalCertificate: '',
        invoice: '',
      ));
}
