import 'package:cloud_firestore/cloud_firestore.dart';

class Competition {
  final String id;
  final String address;
  final String title;
  final String subtitle;
  final String date;
  final String poussin;
  final String benjamin;
  final String minime;

  Competition(
      {required this.id,
      required this.address,
      required this.title,
      required this.subtitle,
      required this.date,
      required this.poussin,
      required this.benjamin,
      required this.minime});

  factory Competition.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data != null) {
      return Competition(
        id: doc.id,
        address: data['address'] ?? '',
        title: data['title'] ?? '',
        subtitle: data['subtitle'] ?? '',
        date: data['date'] ?? '',
        poussin: data['poussin'] ?? '',
        benjamin: data['benjamin'] ?? '',
        minime: data['minime'] ?? '',
      );
    } else {
      throw Exception('Document non trouvé');
    }
  }
}
