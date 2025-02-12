import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/core/utils/date_converter.dart';

@singleton
class Adherents {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime? dateOfBirth;
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

  Adherents({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.dateOfBirth,
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
  });

  String get formattedDateOfBirth {
    return DateFormat('dd/MM/yyyy').format(dateOfBirth!);
  }

  factory Adherents.fromMap(Map<String, dynamic> data, String id) {
    return Adherents(
      id: id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      dateOfBirth: DateConverter.convertToDateTime(data['dateOfBirth']),
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
    );
  }
}
