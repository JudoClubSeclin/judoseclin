import '../../../../domain/entities/cotisation.dart';

abstract class CotisationEvent {}

class CotisationSignUpEvent extends CotisationEvent {
  final String id;
  final String adherentId;
  final int amount;
  final String date;
  final List<Cheque> cheques;
  final String bankName;

  CotisationSignUpEvent({
    required this.id,
    required this.adherentId,
    required this.amount,
    required this.date,
    required this.cheques,
    required this.bankName,
  });
}