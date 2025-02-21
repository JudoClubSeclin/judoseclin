import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/repository/user_repository/auth_state_repository.dart';

import '../../data/repository/user_repository/user_data_repository.dart';

@injectable
class FetchUserDataUseCase {
  final UserDataRepository _usersDataRepository;
  final AuthStateRepository _authStateRepository;

  FetchUserDataUseCase(this._usersDataRepository, this._authStateRepository);

  /// Récupère les données de l'utilisateur pour un ID donné.
  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      return await _usersDataRepository.fetchUserData(userId);
    } catch (e) {
      debugPrint("Erreur lors de la récupération des données utilisateur: $e");
      rethrow;
    }
  }

  /// Vérifie l'état d'authentification.
  Future<void> isUserConnected() async {
    try {
      _authStateRepository.isUserConnected;
    } catch (e) {
      debugPrint(
          "Erreur lors de la vérification de l'état d'authentification: $e");
      rethrow;
    }
  }
}
