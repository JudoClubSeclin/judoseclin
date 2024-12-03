import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/repository/user_repository/user_data_repository.dart';

@Injectable(as: UserDataRepository)
class UserDataRepositoryImpl implements UserDataRepository {
  final FirebaseFirestore _firestore;

  UserDataRepositoryImpl(this._firestore);

  @override
  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      final docSnapshot = await _firestore.collection('Users').doc(userId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data()!;
      }
      throw Exception('Utilisateur non trouvé');
    } catch (e) {
      throw Exception('Erreur lors de la récupération des données utilisateur : $e');
    }
  }

  @override
  Future<void> updateUserData(String userId, Map<String, dynamic> newData) async {
    try {
      await _firestore.collection('Users').doc(userId).update(newData);
    } catch (e) {
      throw Exception('Erreur lors de la mise à jour des données utilisateur : $e');
    }
  }
}
