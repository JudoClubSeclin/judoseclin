import 'package:intl/intl.dart';
import '../../core/utils/date_converter.dart';

class Competition {
  final String id;
  final String address;
  final String title;
  final String subtitle;
  final DateTime date;
  final DateTime publishDate;

  final String? poussin;
  final String? benjamin;
  final String? minime;
  final String? cadet;
  final String? juniorSenior;

  final String? minBeltPoussin;
  final String? minBeltBenjamin;
  final String? minBeltMinime;
  final String? minBeltCadet;
  final String? minBeltJuniorSenior;

  Competition({
    required this.id,
    required this.address,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.publishDate,
    this.poussin,
    this.benjamin,
    this.minime,
    this.cadet,
    this.juniorSenior,
    this.minBeltPoussin,
    this.minBeltBenjamin,
    this.minBeltMinime,
    this.minBeltCadet,
    this.minBeltJuniorSenior,
  });

  /// Formatte la date de publication au format JJ/MM/AAAA
  String get formattedPublishDate {
    return DateFormat('dd/MM/yyyy').format(publishDate);
  }

  /// Vérifie si la compétition est à venir
  bool get isInFuture {
    return date.isAfter(DateTime.now());
  }

  /// Crée une instance depuis une Map (ex: Firestore)
  factory Competition.fromMap(Map<String, dynamic>? data, String id) {
    if (data == null) {
      throw ArgumentError('data map cannot be null');
    }

    return Competition(
      id: id,
      address: data['address'] ?? '',
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      date: DateConverter.convertToDateTime(data['date']),
      publishDate: DateConverter.convertToDateTime(data['publishDate']),
      poussin: data['poussin'],
      benjamin: data['benjamin'],
      minime: data['minime'],
      cadet: data['cadet'],
      juniorSenior: data['juniorSenior'],
      minBeltPoussin: data['minBeltPoussin'],
      minBeltBenjamin: data['minBeltBenjamin'],
      minBeltMinime: data['minBeltMinime'],
      minBeltCadet: data['minBeltCadet'],
      minBeltJuniorSenior: data['minBeltJuniorSenior'],
    );
  }

  /// Constructeur automatique avec publishDate = maintenant
  factory Competition.publish({
    required String id,
    required String address,
    required String title,
    required String subtitle,
    required DateTime date,
    String? poussin,
    String? benjamin,
    String? minime,
    String? cadet,
    String? juniorSenior,
    String? minBeltPoussin,
    String? minBeltBenjamin,
    String? minBeltMinime,
    String? minBeltCadet,
    String? minBeltJuniorSenior,
  }) {
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
      minBeltPoussin: minBeltPoussin,
      minBeltBenjamin: minBeltBenjamin,
      minBeltMinime: minBeltMinime,
      minBeltCadet: minBeltCadet,
      minBeltJuniorSenior: minBeltJuniorSenior,
    );
  }

  /// Transforme l'objet en Map (ex: pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'title': title,
      'subtitle': subtitle,
      'date': date.toIso8601String(),
      'publishDate': publishDate.toIso8601String(),
      'poussin': poussin,
      'benjamin': benjamin,
      'minime': minime,
      'cadet': cadet,
      'juniorSenior': juniorSenior,
      'minBeltPoussin': minBeltPoussin,
      'minBeltBenjamin': minBeltBenjamin,
      'minBeltMinime': minBeltMinime,
      'minBeltCadet': minBeltCadet,
      'minBeltJuniorSenior': minBeltJuniorSenior,
    };
  }
}
