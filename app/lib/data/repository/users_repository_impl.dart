import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/data/repository/user_repository/user_repository.dart';

import '../../core/di/api/auth_service.dart';
import '../../core/di/api/firestore_service.dart';
import '../../domain/entities/entity_module.dart';
import '../../domain/entities/users.dart';

class UserRepositoryImpl extends UsersRepository {
  final _firestoreService = getIt<FirestoreService>();
  final _auth = getIt<AuthService>();

  @override
  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      User? currentUser = _auth.currentUser;
      DocumentSnapshot snapshot = await _firestoreService
          .collection('Users')
          .doc(currentUser!.uid)
          .get();
      return snapshot.data() as Map<String, dynamic>;
    } catch (error) {
      debugPrint('Error fetching user data: $error');
      rethrow;
    }
  }

  @override
  Future<void> registerUser(Users userId) async {
    try {
      User? result = await _auth.createUserWithEmailAndPassword(
        email: userId.email,
        password: userId.password,
      );
      await _firestoreService.collection('Users').doc(result!.uid).set({
        'email': userId.email,
        'firstName': userId.firstName,
        'lastName': userId.lastName,
        'dateOfBirth': userId.dateOfBirth
      });
    } catch (error) {
      debugPrint('Error registering user: $error');
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      return await _auth.signIn(email, password);
    } catch (e) {
      debugPrint("Erreur d'authentification : $e");
      throw Exception("Échec de l'authentification : $e");
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email);
    } catch (error) {
      debugPrint("Erreur de réinitialisation du mot de passe : $error");
      if (error is FirebaseAuthException) {
        throw Exception(
            "Échec de la réinitialisation du mot de passe : $error");
      }
      rethrow;
    }
  }
}

