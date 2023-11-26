import 'package:cloud_firestore/cloud_firestore.dart';

class AdherentsInteractor {
  final FirebaseFirestore firestore;

  AdherentsInteractor({required this.firestore});

  Future<void> addAdherents(
    String id,
    String firstName,
    String lastName,
    String email,
    String dateOfBirth,
    String licence,
    String belt,
    String discipline,
    String category,
    String tutor,
    String phone,
    String address,
    String image,
    String sante,
    String medicalCertificate,
    String invoice,
    List<dynamic> payement,
  ) {
    return firestore.collection('adherents').add({
      'nom': firstName,
      'prenom': lastName,
      'email': email,
      'dateDeNaissance': dateOfBirth,
      'licence': licence,
      'ceinture': belt,
      'discipline': discipline,
      'categorie': category,
      'tuteur': tutor,
      'phone': phone,
      'adresse': address,
      'droitAImage': image,
      'droitUrgence': sante,
      'certificatMedical': medicalCertificate,
      'facture': invoice,
      'paiement': payement,
    }).catchError((error) => throw error);
  }
}
