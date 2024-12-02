import 'package:intl/intl.dart';

import '../../core/utils/date_converter.dart';

class Competition {
  final String id;
  final String address;
  final String title;
  final String subtitle;
  final DateTime? date;
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
     this.date,
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
  bool? get isInFuture {
    return date?.isAfter(DateTime.now());
  }

  // Constructeur de la classe à partir d'une map
  factory Competition.fromMap(Map<String, dynamic>? data, String id) {
    return Competition(
      id: id,
      address: data?['address'] ?? '',
      title: data?['title'] ?? '',
      subtitle: data?['subtitle'] ?? '',
      date: DateConverter.convertToDateTime(data?['date']),
      publishDate: DateConverter.convertToDateTime(data?['publishDate']),
      poussin: data?['poussin'] ?? '',
      benjamin: data?['benjamin'] ?? '',
      minime: data?['minime'] ?? '',
      cadet: data?['cadet'] ?? '',
      juniorSenior: data?['juniorSenior'] ?? '',
    );
  }

  // Méthode de création d'une compétition avec publishDate automatique
  factory Competition.publish({
    required String id,
    required String address,
    required String title,
    required String subtitle,
    required DateTime date,
    required String poussin,
    required String benjamin,
    required String minime,
    required String cadet,
    required String juniorSenior,
  }) {
    return Competition(
      id: id,
      address: address,
      title: title,
      subtitle: subtitle,
      date: DateConverter.convertToDateTime(date),
      publishDate: DateTime.now(),
      poussin: poussin,
      benjamin: benjamin,
      minime: minime,
      cadet: cadet,
      juniorSenior: juniorSenior,
    );
  }
}
