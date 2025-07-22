import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/core/di/injection.dart';
import 'package:judoseclin/data/repository/cotisation_repository.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';

@injectable
class FetchCotisationDataUseCase {
  final cotisationRepository = getIt<CotisationRepository>();

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
      Map<String, dynamic>? cotisationData = await cotisationRepository.getById(
        cotisationId,
      );
      return cotisationData != null
          ? Cotisation.fromFMap(cotisationData, cotisationId)
          : null;
    } catch (e) {
      debugPrint('error fetching cotisation by ID: $e');
      rethrow;
    }
  }

  Future<Iterable<Cotisation>> getCotisationsByAdherentId(String adherentId) async {
    try {
      debugPrint("Fetching cotisations for adherentId: $adherentId");
      Stream<Iterable<Cotisation>> cotisationsStream =
      cotisationRepository.getCotisationsByAdherentId(adherentId);
      return await cotisationsStream.first;
    } catch (e) {
      debugPrint('error fetching cotisations by adherentId: $e');
      return [];
    }
  }
}
