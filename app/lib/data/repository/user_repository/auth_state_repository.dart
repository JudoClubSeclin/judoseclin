import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthStateRepository {
  Stream<User?> get currentUser;
  Stream<bool> get isUserConnected;
}
