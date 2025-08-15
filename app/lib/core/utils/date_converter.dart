import 'package:cloud_firestore/cloud_firestore.dart';

class DateConverter {
  static DateTime convertToDateTime(dynamic value) {
    if (value == null) {
      return DateTime.now(); // valeur de secours
    }

    if (value is DateTime) {
      return value;
    } else if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return DateTime.now(); // fallback si le parsing échoue
      }
    }

    // Valeur par défaut si le type est inconnu
    return DateTime.now();
  }
}
