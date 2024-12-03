

import 'package:firebase_auth/firebase_auth.dart';

abstract class UserAuthRepository {
  Future<User?> login(String email, String password);
  Future<void> register(String email, String password, Map<String, dynamic> userInfo);
  Future<void> logOut();
  Future<void> resetPassword(String email);
}