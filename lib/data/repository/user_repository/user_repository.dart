import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class UsersRepository {
  FirebaseFirestore get firestore;

  User? get currentUser;
  Future<Map<String, dynamic>> fetchUserData();
}

class ConcretedUserRepository extends UsersRepository {
  @override
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<Map<String, dynamic>> fetchUserData() async {
    try {
      if (currentUser != null) {
        DocumentSnapshot snapshot =
            await firestore.collection('Users').doc(currentUser!.uid).get();
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
  User? get currentUser => auth.currentUser;

  FirebaseFirestore get firestoreInstance => firestore;
}
