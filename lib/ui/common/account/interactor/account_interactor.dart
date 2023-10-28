import 'package:judoseclin/domain/usecases/user/fetch_user_data.dart';

class AccountInteractor {
  final fetchUserDataDomain = FetchUserDataUseCase();

  AccountInteractor();

  Future<Map<String, dynamic>> fetchUserData() => fetchUserDataDomain.invoke();
}
