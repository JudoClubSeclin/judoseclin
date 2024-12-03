import '../../../domain/entities/users.dart';

abstract class UsersRepository {
  Future<Map<String, dynamic>> fetchUserData(String userId);

  Future<void> registerUser(Users userId);

  Future<void> login(String email, String password);

  Future<void> resetPassword(String email);

  Future<void> checkAuthenticationStatus();
  
  Future<void> logOut();
}
