import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

Future<void> envoyerEmailInvitation({
  required String email,
  required String nom,
  required String prenom,
}) async {
  final FirebaseFunctions functions = FirebaseFunctions.instance;
  final HttpsCallable callable = functions.httpsCallable('sendEmail');

  try {
    final response = await callable.call(<String, dynamic>{
      'to': email, // E-mail de l'adhérent
      'subject': 'Créer votre compte', // Sujet de l'e-mail
      'text': 'Bonjour $prenom $nom,\n\n'
          'Votre fiche adhérent a été créée. '
          'Veuillez créer votre compte en cliquant sur ce lien : '
          'https://votre-app.com/creer-compte?email=$email\n\n'
          'Cordialement,\nL\'équipe du club.',
    });

    debugPrint('E-mail envoyé : ${response.data}');
  } on FirebaseFunctionsException catch (e) {
    debugPrint('Erreur lors de l\'envoi de l\'e-mail : ${e.message}');
  } catch (e) {
    debugPrint('Erreur lors de l\'envoi de l\'e-mail : $e');
  }
}