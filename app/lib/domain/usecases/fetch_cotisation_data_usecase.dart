import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/repository/cotisation_repository.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';


@injectable
class FetchCotisationDataUseCase {
  final CotisationRepository cotisationRepository;

  FetchCotisationDataUseCase(this.cotisationRepository);

  Future<Iterable<Cotisation>> getCotisation() async {
    try {
      debugPrint("Fetching cotisation data from Firestore...");

      Stream<Iterable<Cotisation>> cotisationStream =
          cotisationRepository.getCotisationStream();
      return await cotisationStream.first;
    } catch (e) {
      debugPrint('error fetching cotisation data: $e');
      return [];
    }
  }

  Future<Cotisation?> getCotisationById(String cotisationId) async {
    try {
      debugPrint("Fetching cotisation data from Firestore...");
      Map<String, dynamic>? cotisationData =
          await cotisationRepository.getById(cotisationId);
      return cotisationData != null
          ? Cotisation.fromFMap(cotisationData, cotisationId)
          : null;
    } catch (e) {
      debugPrint('error fetching cotisation by ID: $e');
      rethrow;
    }
  }
}
