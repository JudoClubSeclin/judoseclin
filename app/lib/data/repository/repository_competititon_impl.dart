

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
}