import 'package:cloud_firestore/cloud_firestore.dart';

class Adherents {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String dateOfBirth;
  final String licence;
  final String blet;
  final String discipline;
  final String category;
  final String tutor;
  final String phone;
  final String address;
  final String image;
  final String sante;
  final String medicalCertificate;
  final String invoice;

  Adherents({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.licence,
    required this.blet,
    required this.discipline,
    required this.category,
    required this.tutor,
    required this.phone,
    required this.address,
    required this.image,
    required this.sante,
    required this.medicalCertificate,
    required this.invoice,
  });

  factory Adherents.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data != null) {
      return Adherents(
        id: doc.id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        email: data['email'] ?? '',
        dateOfBirth: data['dateOfBirth'] ?? '',
        licence: data['licence'] ?? '',
        blet: data['blet'] ?? '',
        discipline: data['discipline'] ?? '',
        category: data['category'] ?? '',
        tutor: data['tutor'] ?? '',
        phone: data['phone'] ?? '',
        address: data['address'] ?? '',
        image: data['image'] ?? '',
        sante: data['sante'] ?? '',
        medicalCertificate: data['medicalCertificate'] ?? '',
        invoice: data['invoice'] ?? '',
      );
    } else {
      throw Exception('Document non trouver');
    }
  }
}
