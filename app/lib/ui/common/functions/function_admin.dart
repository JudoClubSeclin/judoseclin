import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<bool> hasAccess() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;

    // Vérifiez si l'utilisateur est connecté
    if (user != null) {
      // Récupérez le document de l'utilisateur à partir de la collection 'users'
      var userDoc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .get();

      // Vérifiez si le document existe et a une propriété "admin" égale à true
      if (userDoc.exists) {
        var isAdmin = userDoc.data()?['admin'] == true;
        return isAdmin; // L'utilisateur est autorisé si "admin" est égal à true
      } else {
        // Gérer le cas où le document de l'utilisateur n'existe pas
        debugPrint('Document utilisateur non trouvé');
        return false;
      }
    } else {
      return false; // L'utilisateur n'est pas autorisé s'il n'est pas connecté
    }
  } catch (e) {
    debugPrint('Erreur lors de la vérification de l\'accès: $e');
    return false;
  }
}
