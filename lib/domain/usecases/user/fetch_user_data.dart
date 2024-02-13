import 'package:judoseclin/data/repository/user_repository/user_repository.dart';

class FetchUserDataUseCase {
  final UsersRepository usersRepository;

  FetchUserDataUseCase(this.usersRepository);

  Future<Map<String, dynamic>> invoke() async {
    return await usersRepository.fetchUserData();
  }
}
