
import '../../domain/entities/cotisation.dart';

class CotisationDto {
  final String id;
  final String adherentId;
  final int amount;
  final String date;
  final List<Cheque> cheques;
  final String bankName;

  CotisationDto({
    required this.id,
    required this.adherentId,
    required this.amount,
    required this.date,
    required this.cheques,
    required this.bankName,
});
}