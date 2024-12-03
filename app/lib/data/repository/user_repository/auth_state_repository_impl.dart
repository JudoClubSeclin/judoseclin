import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'auth_state_repository.dart';

@Injectable(as: AuthStateRepository)
class AuthStateRepositoryImpl implements AuthStateRepository {
  final FirebaseAuth _firebaseAuth;

  AuthStateRepositoryImpl(this._firebaseAuth);

  @override
  Stream<User?> get currentUser => _firebaseAuth.authStateChanges();

  @override
  Stream<bool> get isUserConnected =>
      _firebaseAuth.authStateChanges().map((user) => user != null);
}
