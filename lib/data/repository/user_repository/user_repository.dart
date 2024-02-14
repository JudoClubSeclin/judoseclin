import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/users.dart';

abstract class UsersRepository {
  FirebaseFirestore get firestore;

  Future<Map<String, dynamic>> fetchUserData();
  Future<void> registerUser(Users users);
}

class ConcretedUserRepository extends UsersRepository {
  @override
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<Map<String, dynamic>> fetchUserData() async {
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
  Future<void> registerUser(Users users) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
        email: users.email,
        password: users.password,
      );
      //Enregistrez l'utilisateur dans la collection 'User'
      await firestore.collection('Users').doc(result.user!.uid).set({
        'email': users.email,
        'firstName': users.firstName,
        'lastName': users.lastName,
        'dateOfBirth': users.dateOfBirth
      });
    } catch (error) {
      debugPrint('Error registering user : $error');
    }
  }
}
