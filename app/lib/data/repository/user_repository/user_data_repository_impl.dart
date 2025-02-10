import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/repository/user_repository/user_data_repository.dart';

import '../../../domain/entities/competition.dart';

@Injectable(as: UserDataRepository)
class UserDataRepositoryImpl implements UserDataRepository {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      final docSnapshot = await firestore.collection('Users').doc(userId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data()!;
      }
      throw Exception('Utilisateur non trouvé');
    } catch (e) {
      throw Exception(
          'Erreur lors de la récupération des données utilisateur : $e');
    }
  }

  @override
  Future<void> updateUserData(
      String userId, Map<String, dynamic> newData) async {
    try {
      await firestore.collection('Users').doc(userId).update(newData);
    } catch (e) {
      throw Exception(
          'Erreur lors de la mise à jour des données utilisateur : $e');
    }
  }
Future<List<Competition>> fetchUserCompetitions(String userId) async {
  final registrationsSnapshot = await firestore
      .collection('competition-registration')
      .where('userId', isEqualTo: userId)
      .get();

  List<Competition> competitions = [];

  for (var doc in registrationsSnapshot.docs) {
    String competitionId = doc['competitionId'];

    final competitionSnapshot = await firestore
        .collection('competition')
        .doc(competitionId)
        .get();

    if (competitionSnapshot.exists) {
      competitions.add(Competition.fromMap(competitionSnapshot.data(), competitionSnapshot.id));
    }
  }

  return competitions;
}

  @override
  Future<void> fetchUserCompetition(String userId) {
    // TODO: implement fetchUserCompetition
    throw UnimplementedError();
  }

}



