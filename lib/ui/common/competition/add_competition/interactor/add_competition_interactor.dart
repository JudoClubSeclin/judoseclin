import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../domain/entities/competition.dart';
import '../../../../../domain/usecases/competitions/fetch_add_comptetition_data_usecase.dart';

class AddCompetitionInteractor {
  final FetchAddCompetitionDataUseCase fetchAddCompetitionDataUseCase;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  AddCompetitionInteractor(this.fetchAddCompetitionDataUseCase, this.firestore);

  Future<void> addCompetition(Competition competition) async {
    try {
      await firestore.collection('competition').add({
        'address': competition.address,
        'title': competition.title,
        'subtitle': competition.subtitle,
        'date': competition.date,
        'publishDate': competition.publishDate,
        'poussin': competition.poussin,
        'benjamin': competition.benjamin,
        'minime': competition.minime,
        'cadet': competition.cadet,
        'juniorSenior': competition.juniorSenior,
      });
    } catch (error) {
      debugPrint('Erreur lors de l\'ajout de la compétition : $error');
      rethrow;
    }
  }

  Future<Competition?> getCompetitionById(String competitionId) async {
    try {
      return await fetchAddCompetitionDataUseCase
          .getCompetitionById(competitionId);
    } catch (e) {
      debugPrint(
          'Erreur lors de la récupération de la compétition par ID : $e');
      rethrow;
    }
  }

  Future<void> updateCompetitionField({
    required String id,
    required String fieldName,
    required String newValue,
  }) async {
    try {
      Map<String, dynamic> updateData = {fieldName: newValue};
      await firestore.collection('competition').doc(id).update(updateData);
    } catch (error) {
      debugPrint('Erreur lors de la mise à jour du champ : $error');
      rethrow;
    }
  }
}
