import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  CollectionReference<Map<String, dynamic>> collection(String path) {
    return _firestore.collection(path);
  }

  Future<DocumentReference<Map<String, dynamic>>> addData(
    String collectionPath,
    Map<String, dynamic> data,
  ) async {
    return await _firestore.collection(collectionPath).add(data);
  }

  Future<List<Map<String, dynamic>>> getData(
    String collectionPath, {
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>>)?
    queryBuilder,
  }) async {
    Query<Map<String, dynamic>> query = _firestore.collection(collectionPath);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<void> updateData(
    String collectionPath,
    String documentId,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection(collectionPath).doc(documentId).update(data);
  }

  Future<void> deleteData(String collectionPath, String documentId) async {
    await _firestore.collection(collectionPath).doc(documentId).delete();
  }

  CollectionReference getCollection(String collectionPath) {
    return _firestore.collection(collectionPath);
  }
}
