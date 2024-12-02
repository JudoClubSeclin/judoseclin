import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';


@injectable
class FetchInscriptionCompetitionDataUseCase {
  final firestore = FirebaseFirestore.instance;

  FetchInscriptionCompetitionDataUseCase();

  Future<void> registerForCompetition(
      String userId, String competitionId) async {
    try {
      await firestore.collection('competition-registration').add({
        'userId': userId,
        'competitionId': competitionId,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // Gérer le succès de l'inscription (par exemple, en émettant un état de réussite).
    } catch (e) {
      debugPrint(e.toString());
      // Gérez l'erreur de l'inscription (par exemple, en émettant un état d'erreur).
      rethrow; // Lancez l'erreur pour que la partie appelante puisse la gérer.
    }
  }
}
