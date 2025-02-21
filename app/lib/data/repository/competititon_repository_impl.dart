

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../core/di/api/firestore_service.dart';
import '../../domain/entities/competition.dart';
import 'competition_repository.dart';


@injectable
class CompetitionRepositoryImpl extends CompetitionRepository {
  final  FirestoreService _firestoreService;

  CompetitionRepositoryImpl(this._firestoreService);


  @override
  Stream<Iterable<Competition>> getCompetitionStream() {
    return _firestoreService.collection('competition').snapshots().map(
          (querySnapshot) => querySnapshot.docs
          .map((doc) => Competition.fromMap(doc.data(), doc.id))
          .toList(),
    );
  }

  @override
  Future<Map<String, dynamic>> getById(String competitionId) async {
    final docSnapshot =
    await _firestoreService.collection('competition').doc(competitionId).get();

    return docSnapshot.data() ?? {};
  }

  @override
  Future<void> add(Map<String, dynamic> data) async {
    await _firestoreService.collection('competition').add(data);
  }

  @override
  Future<void> updateField(
      String competitionId, String fieldName, String newValue) async {
    await _firestoreService
        .collection('competition')
        .doc(competitionId)
        .update({fieldName: newValue});
  }

  @override
  Future<List<String>> getUserCompetitionIds(String userId) async {
    try {
      QuerySnapshot registrationsSnapshot = await _firestoreService
          .collection('competition-registration')
          .where('userId', isEqualTo: userId)
          .get();

      return registrationsSnapshot.docs
          .map((doc) => doc['competitionId'] as String)
          .toList();
    } catch (e) {
      // Gérer l'erreur de manière appropriée
      throw Exception('Erreur lors de la récupération des IDs de compétition');
    }
  }

  @override
  Future<Map<String, String>> getCompetitionTitles(List<String> competitionIds) async {
    try {
      Map<String, String> titles = {};
      for (String id in competitionIds) {
        DocumentSnapshot competitionDoc = await _firestoreService.collection('competition').doc(id).get();
        if (competitionDoc.exists) {
          titles[id] = competitionDoc['title'] as String;
        }
      }
      return titles;
    } catch (e) {
      // Gérer l'erreur de manière appropriée
      throw Exception('Erreur lors de la récupération des titres de compétition');
    }
  }



}