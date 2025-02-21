import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'auth_state_repository.dart';

@Injectable(as: AuthStateRepository)
class AuthStateRepositoryImpl implements AuthStateRepository {
  final firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> get currentUser => firebaseAuth.authStateChanges();

  @override
  Stream<bool> get isUserConnected =>
      firebaseAuth.authStateChanges().map((user) => user != null);
}
