import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/domain/usecases/adherents/fetch_adherents_data_usecase.dart';

class AdherentsInteractor {
  final FetchAdherentsDataUseCase fetchAdherentsDataUseCase;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  AdherentsInteractor(this.fetchAdherentsDataUseCase, this.firestore);

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
    return firestore.collection('adherents').add({
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
    }).catchError((error) => throw error);
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
    Map<String, dynamic> updatedData = {fieldName: newValue};
    return firestore
        .collection('adherents')
        .doc(adherentId)
        .update(updatedData)
        .catchError((error) => throw error);
  }
}
