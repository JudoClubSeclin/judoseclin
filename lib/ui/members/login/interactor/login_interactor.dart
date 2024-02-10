import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/routes/router_config.dart';

class LoginInteractor {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception(
          "Veuillez fournir une adresse e-mail et un mot de passe valides.");
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } catch (e) {
      debugPrint("Erreur d'authentification : $e");
      if (e is FirebaseAuthException) {
        throw Exception("Échec de l'authentification : ${e.message}");
      }
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      debugPrint("Erreur de réinitialisation du mot de passe : $e");
      if (e is FirebaseAuthException) {
        throw Exception(
            "Échec de la réinitialisation du mot de passe : ${e.message}");
      }
      rethrow;
    }
  }

  Future<void> checkAuthenticationStatus() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // L'utilisateur est déjà connecté, redirigez-le vers la page du compte.
      goRouter.go('/account');
    } else {
      // L'utilisateur n'est pas connecté, redirigez-le vers la page d'accueil.
      goRouter.go('/');
    }
  }
}
