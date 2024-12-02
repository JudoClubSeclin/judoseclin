

import '../../domain/entities/cotisation.dart';

class CotisationInfoDto {
  final String id;
  final String adherentId;
  final int amount;
  final String date;
  final List<Cheque> cheques;
  final String bankName;

  CotisationInfoDto({
    required this.id,
    required this.adherentId,
    required this.amount,
    required this.date,
    required this.cheques,
    required this.bankName,
});

  factory CotisationInfoDto.fromJson(Map<String, dynamic> json) {
    return CotisationInfoDto(
        id: json ['id'],
        adherentId: json ['adherentId'],
        amount: json ['amount'],
        date: json ['date'],
        cheques: json  ['cheques'],
        bankName: json ['bankName']
    );
  }

}