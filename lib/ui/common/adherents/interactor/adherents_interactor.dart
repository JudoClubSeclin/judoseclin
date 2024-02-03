import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/domain/usecases/adherents/fetch_adherents_data_usecase.dart';

import '../adherents_repository/adherents_repository.dart';

class AdherentsInteractor {
  final FetchAdherentsDataUseCase fetchAdherentsDataUseCase;
  final AdherentsRepository adherentsRipository;

  AdherentsInteractor(this.fetchAdherentsDataUseCase, this.adherentsRipository);

  Future<void> addAdherents(
    String id,
    String firstName,
    String lastName,
    String email,
    String dateOfBirth,
    String licence,
    String blet,
    String discipline,
    String category,
    String tutor,
    String phone,
    String address,
    String image,
    String sante,
    String medicalCertificate,
    String invoice,
  ) {
    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'licence': licence,
      'blet': blet,
      'discipline': discipline,
      'category': category,
      'tutor': tutor,
      'phone': phone,
      'address': address,
      'droitAImage': image,
      'sante': sante,
      'medicalCertificate': medicalCertificate,
      'invoice': invoice,
    };

    return adherentsRipository.add(data).catchError((error) => throw error);
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
      await adherentsRipository.updateField(adherentId, fieldName, newValue);
    } catch (error) {
      rethrow;
    }
  }
}
