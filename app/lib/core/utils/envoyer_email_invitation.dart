import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

Future<bool> envoyerEmailInvitation({
  required String email,
  required String nom,
  required String prenom,
}) async {
  try {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'sendEmail',
      options: HttpsCallableOptions(
        timeout: const Duration(seconds: 30),
      ),
    );

    // Texte de l'email
    final messageText = 'Bonjour $prenom $nom,\n\n'
        'Votre fiche adhérent a été créée. '
        'Veuillez créer votre compte en cliquant sur le lien ci-dessous.\n\n'
        'Cordialement,\nL\'équipe du judo club Seclin.';

    // ENCODEZ L'URL CORRECTEMENT - AJOUTEZ CES 3 LIGNES
    final baseUrl = 'https://judoseclin.fr/#/inscription';
    final emailEncoded = Uri.encodeComponent(email);
    final lienComplet = '$baseUrl?email=$emailEncoded';

    final response = await callable.call(<String, dynamic>{
      'to': email,
      'subject': 'Créer votre compte',
      'text': messageText,
      'lien': lienComplet, // Utilisez la nouvelle URL encodée
    });

    debugPrint('Réponse du serveur: ${response.data}');

    if (response.data['success'] == true) {
      debugPrint('Email envoyé avec succès à: $email');
      return true;
    } else {
      debugPrint('Échec de l\'envoi: ${response.data}');
      return false;
    }
  } on FirebaseFunctionsException catch (e) {
    debugPrint('ERREUR Firebase Functions:');
    debugPrint('Code: ${e.code}');
    debugPrint('Message: ${e.message}');
    debugPrint('Détails: ${e.details}');
    debugPrint('Stack: ${e.stackTrace}');
    return false;
  } catch (e, stack) {
    debugPrint('ERREUR générale: $e');
    debugPrint('Stack: $stack');
    return false;
  }
}