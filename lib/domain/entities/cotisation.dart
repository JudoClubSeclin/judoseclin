import 'package:cloud_firestore/cloud_firestore.dart';

class Cotisation {
  final String adherentId;
  final String amount;
  final String date;
  final String chequeNumber;
  final String chequeAmount;
  final String bankName;

  Cotisation(
      {required this.adherentId,
      required this.amount,
      required this.date,
      required this.chequeNumber,
      required this.chequeAmount,
      required this.bankName});

  factory Cotisation.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data != null) {
      List<Cheque> cheques = [];
      if (data['cheques'] != null) {
        for (var chequeData in data['cheques']) {
          cheques.add(Cheque.fromMap(chequeData));
        }
      }

      return Cotisation(
          adherentId: data['adherentId'],
          amount: data['amount'] ?? '',
          date: data['date'] ?? '',
          chequeNumber: data['chequeNumber'] ?? '',
          chequeAmount: data['chequeAmount'] ?? '',
          bankName: data['bankName'] ?? '');
    } else {
      throw Exception('Document non trouvé');
    }
  }
}

class Cheque {
  final String numero;
  final int montant;

  Cheque({
    required this.numero,
    required this.montant,
  });

  factory Cheque.fromMap(Map<String, dynamic> map) {
    return Cheque(
      numero: map['numero'] ?? '',
      montant: (map['montant'] ?? 0.0).toDouble(),
    );
  }
}
