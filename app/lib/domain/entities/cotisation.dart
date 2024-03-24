import 'package:flutter/material.dart';

class Cotisation {
  final String id;
  final String adherentId;
  final int amount;
  final String date;
  final List<Cheque> cheques;
  final String bankName;

  Cotisation({
    required this.id,
    required this.adherentId,
    required this.amount,
    required this.date,
    required this.cheques,
    required this.bankName,
  });

  factory Cotisation.fromFMap(Map<String, dynamic> data, String id) {
    try {
      List<Cheque> cheques = [];
      if (data['cheques'] != null) {
        for (var chequeData in data['cheques']) {
          debugPrint('ChequeData from Firestore: $chequeData');
          cheques.add(Cheque.fromMap(chequeData));
        }
        return Cotisation(
            id: id,
            adherentId: data['adherentId'] ?? '',
            amount: (data['amount'] as int?)?.toInt() ?? 0,
            date: data['date'] ?? '',
            cheques: cheques,
            bankName: data['bankName'] ?? '');
      } else {
        throw Exception('Données nul dans le document');
      }
    } catch (e) {
      debugPrint('Erreur lors de la conversion depuis Firestore: $e');
      rethrow;
    }
  }
}

class Cheque {
  final String numeroCheque;
  final int montantCheque;

  Cheque({
    required this.numeroCheque,
    required this.montantCheque,
  });

  Map<String, dynamic> toMap() {
    return {
      'numeroCheque': numeroCheque,
      'montantCheque': montantCheque,
    };
  }

  factory Cheque.fromMap(Map<String, dynamic> map) {
    return Cheque(
      numeroCheque: map['numeroCheque'] ?? '',
      montantCheque: map['montantCheque'] ?? 0,
    );
  }
}
