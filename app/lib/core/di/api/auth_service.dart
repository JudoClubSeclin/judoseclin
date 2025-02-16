
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

import 'firestore_service.dart';

@LazySingleton()
class AuthService extends ChangeNotifier {
  AuthService(this._auth, this._firestore) {
    // Initialisation si nécessaire
  }
  final FirebaseAuth _auth;
  final FirestoreService _firestore;


  // Connexion utilisateur
  Future<User?> signIn(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  // Création d'un utilisateur
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      debugPrint("Erreur lors de la création du compte : $e");
      return null;
    }
  }

  // Déconnexion utilisateur
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Envoi d'un e-mail de réinitialisation de mot de passe
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Récupérer l'utilisateur actuel
  User? get currentUser => _auth.currentUser;

  Future<void> sendInformationEmail(String? email, bool accountExists) async {
    if (email == null) return;

    String subject = accountExists
        ? "Votre compte a été lié à votre profil adhérent"
        : "Activation de votre compte";

    String body = accountExists
        ? "Votre compte utilisateur existant a été lié à votre profil adhérent. Vous pouvez maintenant vous connecter à l'application."
        : "Un compte a été créé pour vous. Veuillez cliquer sur le lien suivant pour activer votre compte et définir votre mot de passe : https://votre-site.com/activation";

    final FirebaseFunctions functions = FirebaseFunctions.instance;
    final HttpsCallable callable = functions.httpsCallable('sendEmail');

    try {
      final response = await callable.call(<String, dynamic>{
        'to': email, // E-mail de l'adhérent
        'subject': subject, // Sujet de l'e-mail
        'text': body,
      });

      debugPrint('E-mail envoyé : ${response.data}');
    } on FirebaseFunctionsException catch (e) {
      debugPrint('Erreur lors de l\'envoi de l\'e-mail : ${e.message}');
    } catch (e) {
      debugPrint('Erreur lors de l\'envoi de l\'e-mail : $e');
    }
  }

  Future<void> linkUserToAdherent(User user) async {
    try {
      if (user.email == null) return;

      QuerySnapshot adherentQuery = await _firestore
          .collection('adherents')
          .where('email', isEqualTo: user.email)
          .limit(1)
          .get();

      if (adherentQuery.docs.isNotEmpty) {
        String adherentId = adherentQuery.docs.first.id;
        Map<String, dynamic> adherentData =
            adherentQuery.docs.first.data() as Map<String, dynamic>;

        await _firestore.collection('adherents').doc(adherentId).update({
          'userId': user.uid,
        });

        await _firestore.collection('users').doc(user.uid).set({
          'adherentId': adherentId,
          'email': user.email,
          'firstName': adherentData['firstName'],
          'lastName': adherentData['lastName'],
          'category': adherentData['category'],
        }, SetOptions(merge: true));

        await sendInformationEmail(user.email, true);
      }
    } catch (e) {
      debugPrint('Erreur lors de la liaison utilisateur-adhérent: $e');
    }
  }
}
