import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {
  final String id;
  final String adherentId;
  final double amount;
  final DateTime date;
  final String chequeNumber;
  final double chequeAmount;
  final String bankName;

  Payment({
    required this.id,
    required this.adherentId,
    required this.amount,
    required this.date,
    required this.chequeNumber,
    required this.chequeAmount,
    required this.bankName,
  });

  factory Payment.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data != null) {
      return Payment(
        id: doc.id,
        adherentId: data['adherentId'] ?? '',
        amount: data['amount'] ?? '',
        date: data['date'] ?? '',
        chequeNumber: data['chequeNumber'] ?? '',
        chequeAmount: data['chequeAmount'] ?? '',
        bankName: data['bankName'] ?? '',
      );
    } else {
      throw Exception('Document non trouver');
    }
  }
}
