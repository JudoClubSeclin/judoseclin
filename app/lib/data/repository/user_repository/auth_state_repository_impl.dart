import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/entity_module.dart';
import 'auth_state_repository.dart';

@Injectable(as: AuthStateRepository)
class AuthStateRepositoryImpl implements AuthStateRepository {
  final  firebaseAuth = getIt<FirebaseAuth>();


  @override
  Stream<User?> get currentUser => firebaseAuth.authStateChanges();

  @override
  Stream<bool> get isUserConnected =>
      firebaseAuth.authStateChanges().map((user) => user != null);
}
