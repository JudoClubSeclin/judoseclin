import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/repository/user_repository/auth_state_repository_impl.dart';
import 'package:judoseclin/data/repository/user_repository/user_data_repository_impl.dart';

import '../../../../domain/entities/users.dart';
import '../../../data/repository/user_repository/user_auth_repository_impl.dart';

@singleton
class UsersInteractor {
  final authUserRepository = UserAuthRepositoryImpl();
  final userData = UserDataRepositoryImpl();
  final stateRepository = AuthStateRepositoryImpl();

  Future<void> registerUser(Users user) async {
    try {
      final userInfo = {
        'firstName': user.firstName,
        'lastName': user.lastName,
        'dateOfBirth': user.dateOfBirth,
        'email': user.email
      };

      await authUserRepository.register(user.email, user.password, userInfo);
    } catch (error) {
      debugPrint('Erreur lors de l\'enregistrement de l\'utilisateur: $error');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      final user = await userData.fetchUserData(userId);
      return user; // Ajoutez cette ligne pour renvoyer les données de l'utilisateur
    } catch (error) {
      debugPrint(
          'Erreur lors de la récupération des données utilisateur : $error');
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      //Utilise le repository pour géger la connexion
      await authUserRepository.login(email, password);
    } catch (error) {
      debugPrint('Error de connection : $error');
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      //utilisez le repository pour la réinitialisation du password
      await authUserRepository.resetPassword(email);
    } catch (error) {
      debugPrint('$error');
    }
  }

  Future<void> checkAuthenticationStatus() async {
    try {
      //Utilisez le repository pour la redirection
      await stateRepository.isUserConnected;
    } catch (error) {
      debugPrint('redirection échoué : $error');
    }
  }

  Future<void> logOut() async {
    await authUserRepository.logOut();
  }
}
