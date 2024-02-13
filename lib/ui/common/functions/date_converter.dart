import 'package:cloud_firestore/cloud_firestore.dart';

class DateConverter {
  static DateTime convertToDateTime(dynamic value) {
    if (value is DateTime) {
      return value;
    } else if (value is Timestamp) {
      return value.toDate();
    }
    // Handle other cases or return a default value if needed
    return DateTime.now();
  }
}
