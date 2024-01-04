import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:judoseclin/domain/entities/payment.dart';
import 'package:judoseclin/domain/usecases/payment/fetch_payment_data_usecase.dart';

class PaymentInteractor {
  final FetchPaymentDataUseCase fetchPaymentDataUseCase;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  PaymentInteractor(this.fetchPaymentDataUseCase, this.firestore);

  Future<void> addPayment(
    String adherentId,
    double amount,
    DateTime date,
    String chequeNumber,
    double chequeAmount,
    String bankName,
  ) {
    return firestore.collection('payment').add({
      'adherentId': adherentId,
      'amount': amount,
      'date': date,
      'chequeNumber': chequeNumber,
      'chequeAmount': chequeAmount,
      'bankName': bankName,
    }).catchError((error) => throw error);
  }

  Future<Iterable<Payment>> fetchAdherentsData() async {
    try {
      return await fetchPaymentDataUseCase.getPayment();
    } catch (e) {
      rethrow;
    }
  }

  Future<Payment?> getPaymentById(String paymentId) async {
    try {
      return await fetchPaymentDataUseCase.getPaymentById(paymentId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePaymentField({
    required String paymentId,
    required String fieldName,
    required String newValue,
  }) async {
    Map<String, dynamic> updatedData = {fieldName: newValue};
    return firestore
        .collection('payment')
        .doc(paymentId)
        .update(updatedData)
        .catchError((error) => throw error);
  }
}
