import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/users.dart';

abstract class UsersRepository {
  FirebaseFirestore get firestore;

  Future<Map<String, dynamic>> fetchUserData(String userId);

  Future<void> registerUser(Users userId);

  Future<void> login(String email, String password);

  Future<void> resetPassword(String email);

  Future<void> checkAuthenticationStatus();
  Future<void> logOut();
}

class ConcretedUserRepository extends UsersRepository {
  @override
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<Map<String, dynamic>> fetchUserData(userId) async {
    try {
      User? currentUser = auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot snapshot =
            await firestore.collection('Users').doc(currentUser.uid).get();
        return snapshot.data() as Map<String, dynamic>;
      } else {
        throw Exception('No current user found.');
      }
    } catch (error) {
      debugPrint('Error fetching user data: $error');
      rethrow;
    }
  }

  @override
  Future<void> registerUser(Users userId) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: userId.email,
        password: userId.password,
      );
      //Enregistrez l'utilisateur dans la collection 'User'
      await firestore.collection('Users').doc(result.user!.uid).set({
        'email': userId.email,
        'firstName': userId.firstName,
        'lastName': userId.lastName,
        'dateOfBirth': userId.dateOfBirth
      });
    } catch (error) {
      debugPrint('Error registering user : $error');
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception(
          "Veuillez fournir une adresse e-mail et un mot de passe valides.");
    }

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
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

  @override
  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (error) {
      debugPrint("Erreur de réinitialisation du mot de passe : $error");
      if (error is FirebaseAuthException) {
        throw Exception(
            "Échec de la réinitialisation du mot de passe : $error");
      }
      rethrow;
    }
  }

  @override
  Future<void> checkAuthenticationStatus() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
  }

  @override
  Future<void> logOut() {
    try {
      FirebaseAuth.instance.signOut();
    } catch (error) {
      debugPrint('Une erreur est survenue : $error');
    }
    throw UnimplementedError();
  }
}
