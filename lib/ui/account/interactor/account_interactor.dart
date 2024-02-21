import 'package:judoseclin/data/repository/user_repository/user_repository.dart';

class AccountInteractor {
  final UsersRepository usersRepository;

  AccountInteractor(this.usersRepository);

  Future<Map<String, dynamic>> invoke(String userId) async {
    return await usersRepository.fetchUserData(userId);
  }

  Future<Map<String, dynamic>> fetchUserData(userId) async {
    return await usersRepository.fetchUserData(userId);
  }
}
