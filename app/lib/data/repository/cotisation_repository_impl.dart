import 'package:judoseclin/core/di/api/firestore_service.dart';
import '../../domain/entities/cotisation.dart';
import 'cotisation_repository.dart';

class CotisationRepositoryImpl extends CotisationRepository {
  final FirestoreService _firestoreService;

  CotisationRepositoryImpl(this._firestoreService);

  @override
  Stream<Iterable<Cotisation>> getCotisationStream() {
    return _firestoreService
        .collection('cotisation')
        .snapshots()
        .map(
          (querySnapshot) =>
              querySnapshot.docs
                  .map((doc) => Cotisation.fromFMap(doc.data(), doc.id))
                  .toList(),
        );
  }

  @override
  Stream<Iterable<Cotisation>> getCotisationsByAdherentId(String adherentId) {
    return _firestoreService
        .collection('cotisation')
        .where('adherentId', isEqualTo: adherentId)
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
          .map((doc) => Cotisation.fromFMap(doc.data(), doc.id))
          .toList(),
    );
  }


  @override
  Future<Map<String, dynamic>?> getById(String cotisationId) {
    return _firestoreService
        .collection('cotisation')
        .doc(cotisationId)
        .get()
        .then((docSnapshot) => docSnapshot.data());
  }

  @override
  Future<void> add(Map<String, dynamic> data, String documentId) async {
    await _firestoreService.collection('cotisation').add(data);
  }

  @override
  Future<void> updateField(
    String cotisationId,
    String fieldName,
    String newValue,
  ) async {
    try {
      await _firestoreService.collection('cotisation').doc(cotisationId).update(
        {fieldName: newValue},
      );
    } catch (e) {
      rethrow;
    }
  }
}
