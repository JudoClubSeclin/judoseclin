import 'package:judoseclin/data/repository/user_repository/user_repository.dart';

class FetchUserDataUseCase {
  final UsersRepository usersRepository;
  final String userId;

  FetchUserDataUseCase(this.usersRepository, this.userId);

  Future<Map<String, dynamic>> invoke() async {
    return await usersRepository.fetchUserData( userId);
  }
  Future <void> checkAuthenticationStatus() async {
    return await usersRepository.checkAuthenticationStatus();
  }
}
