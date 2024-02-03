import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AdherentsRepository {
  FirebaseFirestore get firestore;

  Stream<QuerySnapshot> getAdherentsStream();
  Future<DocumentSnapshot<Object?>> getById(String adherentsId);
  Future<void> add(Map<String, dynamic> data);
  Future<void> updateField(
      String adherentId, String fieldName, String newValue);
}

class ConcreteAdherentsRepository extends AdherentsRepository {
  @override
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot> getAdherentsStream() {
    return firestore.collection('adherents').snapshots();
  }

  @override
  Future<DocumentSnapshot<Object?>> getById(String adherentsId) {
    return firestore.collection('adherents').doc(adherentsId).get();
  }

  @override
  Future<void> add(Map<String, dynamic> data) async {
    await firestore.collection('adherents').add(data);
  }

  @override
  Future<void> updateField(
      String adherentId, String fieldName, String newValue) async {
    await firestore.collection('adherents').doc(adherentId).update({
      fieldName: newValue,
    });
  }

  FirebaseFirestore get firestoreInstance => firestore;
}
