import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';

import '../../../../domain/usecases/cotisation/fetch_cotisation_data_usecase.dart';

class CotisationInteractor {
  final FetchCotisationDataUseCase fetchCotisationDataUseCase;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CotisationInteractor(
    this.fetchCotisationDataUseCase,
    this.firestore,
  );

  Future<void> addCotisation(
    String id,
    String adherentId,
    int amount,
    String date,
    List<Cheque> cheques,
    String bankName,
  ) async {
    List<Map<String, dynamic>> chequesData = cheques
        .map((cheque) => {
              'numero': cheque.numeroCheque,
              'montant': cheque.montantCheque,
            })
        .toList();

    return firestore.collection('cotisation').doc(adherentId).set({
      'adherentId': adherentId,
      'amount': amount,
      'date': date,
      'cheques': chequesData,
      'bankName': bankName,
    }).catchError((error) => throw error);
  }

  Future<Iterable<Cotisation>> fetchAdherentsData() async {
    try {
      return await fetchCotisationDataUseCase.getCotisation();
    } catch (e) {
      rethrow;
    }
  }

  Future<Cotisation?> getCotisationById(String cotisationId) async {
    try {
      return await fetchCotisationDataUseCase.getCotisationById(cotisationId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCotisationField({
    required String id,
    required String fieldName,
    required String newValue,
  }) async {
    Map<String, dynamic> updatedData = {fieldName: newValue};
    return firestore
        .collection('cotisation')
        .doc(id)
        .update(updatedData)
        .catchError((error) => throw error);
  }
}