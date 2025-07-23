import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/domain/usecases/fetch_adherents_data_usecase.dart';

import '../../data/repository/adherents_repository.dart';

class AdherentsInteractor {
  final FetchAdherentsDataUseCase fetchAdherentsDataUseCase;
  final AdherentsRepository adherentsRepository;
  final FirestoreService _firestoreService;

  AdherentsInteractor(this.fetchAdherentsDataUseCase, this.adherentsRepository,
      this._firestoreService);

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
        'additionalAddress': adherents.additionalAddress
      });
    } catch (error) {
      debugPrint('Erreur lors de l\'ajout de l\'adhérent: $error');
    }
  }

  Future<List<Adherents>> fetchAdherentsData() async {
    List<Adherents> adherents = [];
    Set<String> adherentId = {};
    try {
      debugPrint(">>> fetchAdherentsData called");

      QuerySnapshot snapshot = await _firestoreService.collection('adherents').get();
      for (var doc in snapshot.docs) {
        Adherents adherent = Adherents.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        if (adherentId.contains(adherent.id)) continue;  // Pour éviter doublons si besoin
        adherentId.add(adherent.id);
        adherents.add(adherent); // **Ajout de l'objet à la liste**
      }
    } catch (e) {
      debugPrint("Erreur lors de la récupération des adherents : $e");
      rethrow;
    }
    debugPrint(">>> Nombre d'adhérents récupérés: ${adherents.length}");
    return adherents;
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

  Future<List<Adherents>> fetchByFamily(String familyId) {
    return fetchAdherentsDataUseCase.getAdherentsByFamilyId(familyId);

  }

  Future<Map<String, dynamic>?> fetchExistingFamilyByAddress(
      String address) async {
    final snapshot = await _firestoreService.collection('adherents')
        .where('address', isEqualTo: address)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    } else {
      return null;
    }
  }

}

