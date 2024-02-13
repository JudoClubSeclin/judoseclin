import 'package:judoseclin/data/repository/user_repository/user_repository.dart';
import 'package:judoseclin/domain/usecases/user/fetch_user_data.dart';

class AccountInteractor {
  final FetchUserDataUseCase fetchUserDataDomain;

  AccountInteractor(UsersRepository usersRepository)
      : fetchUserDataDomain = FetchUserDataUseCase(usersRepository);

  Future<Map<String, dynamic>> fetchUserData() {
    return fetchUserDataDomain.invoke();
  }
}
