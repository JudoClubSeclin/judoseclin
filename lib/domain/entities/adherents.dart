import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

class Adherents {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String dateOfBirth;
  final String licence;
  final String belt;
  final String discipline;
  final String category;
  final String tutor;
  final String phone;
  final String address;
  final String image;
  final String sante;
  final String medicalCertificate;
  final String invoice;
  final List<String> payement;

  Adherents({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.licence,
    required this.belt,
    required this.discipline,
    required this.category,
    required this.tutor,
    required this.phone,
    required this.address,
    required this.image,
    required this.sante,
    required this.medicalCertificate,
    required this.invoice,
    required this.payement,
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
        belt: data['belt'] ?? '',
        discipline: data['discipline'] ?? '',
        category: data['category'] ?? '',
        tutor: data['tutor'] ?? '',
        phone: data['phone'] ?? '',
        address: data['address'] ?? '',
        image: data['image'] ?? '',
        sante: data['sante'] ?? '',
        medicalCertificate: data['medicalCertificate'] ?? '',
        invoice: data['invoice'] ?? '',
        payement: List<String>.from(data['payement'] ?? []),
      );
    } else {
      throw Exception('Document non trouver');
    }
  }
}
