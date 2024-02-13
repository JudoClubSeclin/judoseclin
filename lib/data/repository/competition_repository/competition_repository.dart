import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/competition.dart';

abstract class CompetitionRepository {
  FirebaseFirestore get firestore;
  Stream<Iterable<Competition>> getCompetitionStream();
  Future<Map<String, dynamic>> getById(String competitionId);
  Future<void> add(Map<String, dynamic> data);
  Future<void> updateField(
      String competitionId, String fieldName, String newValue);
}

class ConcretedCompetitionRepository extends CompetitionRepository {
  @override
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<Iterable<Competition>> getCompetitionStream() {
    return firestore.collection('competition').snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => Competition.fromMap(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Future<Map<String, dynamic>> getById(String competitionId) async {
    final docSnapshot =
        await firestore.collection('competition').doc(competitionId).get();

    return docSnapshot.data() ?? {};
  }

  @override
  Future<void> add(Map<String, dynamic> data) async {
    await firestore.collection('competition').add(data);
  }

  @override
  Future<void> updateField(
      String competitionId, String fieldName, String newValue) async {
    await firestore
        .collection('competition')
        .doc(competitionId)
        .update({fieldName: newValue});
  }
}
