import 'package:cloud_firestore/cloud_firestore.dart';

class Competition {
  final String title;
  final String date;
  final String subtitle;
  final String address;
  final String poussin;
  final String benjamin;
  final String minime;

  Competition({
    required this.title,
    required this.date,
    required this.subtitle,
    required this.address,
    required this.poussin,
    required this.benjamin,
    required this.minime,
  });

  factory Competition.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data != null) {
      return Competition(
        title: data['title'] ?? '',
        date: data['date'] ?? '',
        subtitle: data['subtitle'] ?? '',
        address: data['address'] ?? '',
        poussin: data['poussin'] ?? '',
        benjamin: data['benjamin'] ?? '',
        minime: data['minime'] ?? '',
      );
    } else {
      // Gérer l'erreur comme vous le souhaitez, peut-être en renvoyant une compétition vide ou en levant une exception.
      throw Exception('Document does not exist');
    }
  }
}
