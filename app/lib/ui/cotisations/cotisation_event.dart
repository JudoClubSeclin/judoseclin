import '../../../domain/entities/cotisation.dart';

abstract class CotisationEvent {}

class LoadCotisationsEvent extends CotisationEvent {
  final String adherentId;

  LoadCotisationsEvent(this.adherentId);
}

class AddCotisationSignUpEvent extends CotisationEvent {
  final String id;
  final String adherentId;
  final int amount;
  final String date;
  final List<Cheque> cheques;
  final String bankName;

  AddCotisationSignUpEvent({
    required this.id,
    required this.adherentId,
    required this.amount,
    required this.date,
    required this.cheques,
    required this.bankName,
  });
}
