abstract class CotisationEvent {}

class CotisationSignUpEvent extends CotisationEvent {
  final String adherentId;
  final String amount;
  final String date;
  final String chequeNumber;
  final String chequeAmount;
  final String bankName;

  CotisationSignUpEvent({
    required this.adherentId,
    required this.amount,
    required this.date,
    required this.chequeNumber,
    required this.chequeAmount,
    required this.bankName,
  });
}
