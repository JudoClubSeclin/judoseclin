import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  // Connexion utilisateur
  Future<User?> signIn(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  // Création d'un utilisateur
  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  // Déconnexion utilisateur
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Envoi d'un e-mail de réinitialisation de mot de passe
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Récupérer l'utilisateur actuel
  User? get currentUser => _auth.currentUser;
}
