import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CompetitionRepository {
  FirebaseFirestore get firestore;
  Stream<QuerySnapshot> getCompetitionStream();
  Future<DocumentSnapshot<Object?>> getById(String competitionId);
  Future<void> add(Map<String, dynamic> data);
  Future<void> updateField(
      String competitionId, String fieldName, String newValue);
}

class ConcretedCompetitionRepository extends CompetitionRepository {
  @override
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Object?>> getCompetitionStream() {
    return firestore.collection('competition').snapshots();
  }

  @override
  Future<DocumentSnapshot<Object?>> getById(String competitionId) {
    return firestore.collection('competition').doc(competitionId).get();
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
