import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/domain/usecases/fetch_adherents_data_usecase.dart';

import '../../../data/repository/adherents_repository.dart';

class AdherentsInteractor {
  final FetchAdherentsDataUseCase fetchAdherentsDataUseCase;
  final AdherentsRepository adherentsRepository;

  AdherentsInteractor(this.fetchAdherentsDataUseCase, this.adherentsRepository);

  Future<void> addAdherents(Adherents adherents) async {
    try {
      await adherentsRepository.add({
        'firstName': adherents.firstName,
        'lastName': adherents.lastName,
        'email': adherents.email,
        'dateOfBirth': adherents.dateOfBirth,
        'licence': adherents.licence,
        'belt': adherents.belt,
        'discipline': adherents.discipline,
        'category': adherents.category,
        'tutor': adherents.tutor,
        'phone': adherents.phone,
        'address': adherents.address,
        'droitAImage': adherents.image,
        'sante': adherents.sante,
        'medicalCertificate': adherents.medicalCertificate,
        'invoice': adherents.invoice,
      });
    } catch (error) {
      debugPrint('Erreur lors de l\'ajout de l\'adhérent: $error');
    }
  }

  Future<Iterable<Adherents>> fetchAdherentsData() async {
    try {
      return await fetchAdherentsDataUseCase.getAdherents();
    } catch (e) {
      rethrow;
    }
  }

  Future<Adherents?> getAdherentsById(String adherentsId) async {
    try {
      return await fetchAdherentsDataUseCase.getAdherentsById(adherentsId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateAdherentField({
    required String adherentId,
    required String fieldName,
    required String newValue,
  }) async {
    try {
      await adherentsRepository.updateField(adherentId, fieldName, newValue);
    } catch (error) {
      rethrow;
    }
  }
}
