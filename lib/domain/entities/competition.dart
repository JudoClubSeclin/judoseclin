import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Competition {
  final String id;
  final String address;
  final String title;
  final String subtitle;
  final DateTime date;
  final DateTime publishDate;
  final String poussin;
  final String benjamin;
  final String minime;
  final String cadet;
  final String juniorSenior;

  Competition({
    required this.id,
    required this.address,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.publishDate,
    required this.poussin,
    required this.benjamin,
    required this.minime,
    required this.cadet,
    required this.juniorSenior,
  });
  // Formatte la date au format (DD/MM/YYYY)
  String get formattedPublishDate {
    return DateFormat('dd/MM/yyyy').format(publishDate);
  }

  // vérifie si la date est bien dans le futur
  bool get isInFuture {
    return date.isAfter(DateTime.now());
  }

  factory Competition.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data != null) {
      return Competition(
        id: doc.id,
        address: data['address'] ?? '',
        title: data['title'] ?? '',
        subtitle: data['subtitle'] ?? '',
        date: (data['date'] as Timestamp).toDate(),
        publishDate: (data['publishDate'] as Timestamp).toDate(),
        poussin: data['poussin'] ?? '',
        benjamin: data['benjamin'] ?? '',
        minime: data['minime'] ?? '',
        cadet: data['cadet'] ?? '',
        juniorSenior: data['juniorSenior'] ?? '',
      );
    } else {
      throw Exception('Document non trouvé');
    }
  }
  //Méthode de creation d'une compétition avec publishDate automatique
  factory Competition.publish(
    String id,
    String address,
    String title,
    String subtitle,
    DateTime date,
    String poussin,
    String benjamin,
    String minime,
    String cadet,
    String juniorSenior,
  ) {
    return Competition(
      id: id,
      address: address,
      title: title,
      subtitle: subtitle,
      date: date,
      publishDate: DateTime.now(),
      poussin: poussin,
      benjamin: benjamin,
      minime: minime,
      cadet: cadet,
      juniorSenior: juniorSenior,
    );
  }
}
