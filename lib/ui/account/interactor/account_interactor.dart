import 'package:judoseclin/data/repository/user_repository/user_repository.dart';

class AccountInteractor {
  final UsersRepository usersRepository;
  final String userId;
  AccountInteractor(this.usersRepository, this.userId);

  Future<Map<String, dynamic>> invoke(String userId) async {
    return await usersRepository.fetchUserData(userId);
  }

  Future<Map<String, dynamic>> fetchUserData(userId) async {
    return await usersRepository.fetchUserData(userId);
  }
}
