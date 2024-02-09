import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class InscriptionInteractor {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  InscriptionInteractor({required this.auth, required this.firestore});

  Future<void> signUpToFirebase(String nom, String prenom, String dateNaissance,
      String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .then((value) async {
        if (kDebugMode) {
          print(value.user!.uid);
          await _addUser(
            value.user!.uid,
            nom.trim(),
            prenom.trim(),
            dateNaissance.trim(),
            email.trim(),
          );
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _addUser(String userID, String nom, String prenom,
      String datedenaissance, String email) {
    return firestore.collection('Users').doc(userID).set({
      'nom': nom,
      'prenom': prenom,
      'date de naissance': datedenaissance,
      'email': email
    }).catchError((error) => throw error);
  }
}
