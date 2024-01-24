import 'package:cloud_firestore/cloud_firestore.dart';
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

  factory Cotisation.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    try {
      final data = doc.data();
      if (data != null) {
        List<Cheque> cheques = [];
        if (data['cheques'] != null) {
          for (var chequeData in data['cheques']) {
            cheques.add(Cheque.fromMap(chequeData));
          }
        }

        return Cotisation(
          id: doc.id,
          adherentId: data['adherentId'] ?? '',
          amount: (data['amount'] as int?)?.toInt() ?? 0,
          date: data['date'] ?? '',
          cheques: cheques,
          bankName: data['bankName'] ?? '',
        );
      } else {
        throw Exception('Données nul dans le document');
      }
    } catch (e) {
      debugPrint('Erreur lors de la conversion depuis Firestore: $e');
      rethrow; // Rethrow l'exception pour ne pas cacher l'erreur d'origine.
    }
  }
}

class Cheque {
  final String numeroCheque;
  final String montantCheque; // Garder le type String

  Cheque({
    required this.numeroCheque,
    required this.montantCheque,
  });

  factory Cheque.fromMap(Map<String, dynamic> map) {
    return Cheque(
      numeroCheque: map['numero'] ?? '',
      montantCheque: map['montant'] ?? '',
    );
  }
}
