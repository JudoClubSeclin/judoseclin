abstract class PaymentEvent {}

class SignUpEvent extends PaymentEvent {
  final String adherentId;
  final double amount;
  final DateTime date;
  final String chequeNumber;
  final double chequeAmount;
  final String bankName;

  SignUpEvent({
    required this.adherentId,
    required this.amount,
    required this.date,
    required this.chequeNumber,
    required this.chequeAmount,
    required this.bankName,
  });
}
