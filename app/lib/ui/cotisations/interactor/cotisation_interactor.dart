import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';

import '../../../domain/usecases/fetch_cotisation_data_usecase.dart';
import '../../../data/repository/cotisation_repository.dart';

class CotisationInteractor {
  final FetchCotisationDataUseCase fetchCotisationDataUseCase;
  final CotisationRepository cotisationRepository;

  CotisationInteractor(
    this.fetchCotisationDataUseCase,
    this.cotisationRepository,
  );

  Future<void> addCotisation(Cotisation cotisation) async {
    debugPrint('la je passe et je suis interactor');
    try {
      await cotisationRepository.add({
        'adherentId': cotisation.adherentId,
        'amount': cotisation.amount,
        'date': cotisation.date,
        'cheques': [...cotisation.cheques.map((cheque) => cheque.toMap())],
        'bankName': cotisation.bankName,
      }, cotisation.adherentId);
    } catch (error) {
      debugPrint('Erreur lors de l\'ajout de la cotisation: $error');
    }
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
    required String cotisationId,
    required String fieldName,
    required String newValue,
  }) async {
    try {
      await cotisationRepository.updateField(cotisationId, fieldName, newValue);
    } catch (error) {
      rethrow;
    }
  }
}
