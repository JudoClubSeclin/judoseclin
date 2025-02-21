import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Importez ce package pour debugPrint

Future<void> checkUserConnection(BuildContext context) async {
  // Vérifiez si un utilisateur est connecté
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    debugPrint('Utilisateur déjà connecté: ${currentUser.email}');
    GoRouter.of(context).go('/account');
  } else {
    debugPrint('Aucun utilisateur connecté.');
    GoRouter.of(context).go('/login');
  }
}

String? getCurrentUserEmail() {
  final user = FirebaseAuth.instance.currentUser;
  return user?.email;
}

Future<Map<String, dynamic>?> getAdherentDetails(String email) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('adherents')
      .where('email', isEqualTo: email.toLowerCase())
      .get();

  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first.data(); // Retourne les détails de l'adhérent
  }
  return null; // Aucun adhérent trouvé
}

