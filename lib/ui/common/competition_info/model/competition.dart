import 'package:cloud_firestore/cloud_firestore.dart';

class Competition {
  final String id;
  final String title;
  final DateTime date;
  final String subtitle;
  final String address;
  final String? poussin;
  final String? benjamin;
  final String? minime;

  Competition({
    required this.id,
    required this.title,
    required this.date,
    required this.subtitle,
    required this.address,
    this.poussin,
    this.benjamin,
    this.minime,
  });

  factory Competition.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data != null) {
      return Competition(
        id: doc.id,
        title: data['title'] ?? '',
        date: (data['date'] as Timestamp).toDate(),
        subtitle: data['subtitle'] ?? '',
        address: data['address'] ?? '',
        poussin: data['poussin'],
        benjamin: data['benjamin'],
        minime: data['minime'],
      );
    } else {
      // Gérer l'erreur comme vous le souhaitez, peut-être en renvoyant une compétition vide ou en levant une exception.
      throw Exception('Document does not exist');
    }
  }
}
