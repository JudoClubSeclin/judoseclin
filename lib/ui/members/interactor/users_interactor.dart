import 'package:flutter/material.dart';

import '../../../../data/repository/user_repository/user_repository.dart';
import '../../../../domain/entities/users.dart';

class UsersInteractor {
  final UsersRepository userRepository;

  UsersInteractor({required this.userRepository});

  Future<void> registerUser(Users users) async {
    try {
      //Utilisez le repository pour enregistrer l'utilisateur
      await userRepository.registerUser(Users(
          id: (users.id),
          firstName: users.firstName,
          lastName: users.lastName,
          dateOfBirth: users.dateOfBirth,
          email: users.email,
          password: users.password));
    } catch (error) {
      debugPrint('Erreur lors de l\'enregistrement de user: $error');
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      //Utilise le repository pour géger la connexion
      await userRepository.login(email, password);
    } catch (error) {
      debugPrint('Error de connection : $error');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      //utilisez le repository pour la réinitialisation du password
      await userRepository.resetPassword(email);
    } catch (error) {
      debugPrint('$error');
    }
  }

  Future<void> checkAuthenticationStatus() async {
    try {
      //Utilisez le repository pour la redirection
      await userRepository.checkAuthenticationStatus();
    } catch (error) {
      debugPrint('redirection échoué : $error');
    }
  }
}
