import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'auth_user_repository.dart';

@Injectable(as: AuthUserRepository)
class AuthUserRepositoryImpl implements AuthUserRepository {
  final FirebaseAuth _firebaseAuth;

  AuthUserRepositoryImpl(this._firebaseAuth);

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Erreur lors de la connexion : $e');
    }
  }

  @override
  Future<void> register(String email, String password, Map<String, dynamic> userInfo) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Ajouter des données utilisateur supplémentaires dans Firestore ou ailleurs si nécessaire
    } catch (e) {
      throw Exception('Erreur lors de l\'inscription : $e');
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
