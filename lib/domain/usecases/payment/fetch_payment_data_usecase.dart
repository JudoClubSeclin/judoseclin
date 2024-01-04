import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/payment.dart';

class FetchPaymentDataUseCase {
  final firestore = FirebaseFirestore.instance;

  Future<Iterable<Payment>> getPayment() async {
    try {
      debugPrint("Fetching payments data from Firestore...");

      QuerySnapshot snapshot = await firestore.collection('payment').get();
      debugPrint("Payment data fetched successfully.");

      List<Payment> payment = snapshot.docs
          .map((doc) => Payment.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
      return payment;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Payment?> getPaymentById(String paymentId) async {
    try {
      debugPrint("Fetching adherents data from Firestore...");

      DocumentSnapshot<Map<String, dynamic>> paymentSnapshot =
          await firestore.collection('adherents').doc(paymentId).get();

      if (paymentSnapshot.exists) {
        Payment payment = Payment.fromFirestore(paymentSnapshot);
        return payment;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
