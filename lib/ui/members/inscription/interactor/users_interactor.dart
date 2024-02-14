import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/user/user.dart';

import '../../../../data/repository/user_repository/user_repository.dart';

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
}
