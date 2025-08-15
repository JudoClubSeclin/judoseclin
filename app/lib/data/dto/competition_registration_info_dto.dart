import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/competition_registration.dart';

class CompetitionRegistrationInfoDto {
  final String id;
  final String adherentId;
  final String competitionId;
  final DateTime registrationDeadline;

  CompetitionRegistrationInfoDto({
    required this.id,
    required this.adherentId,
    required this.competitionId,
    required this.registrationDeadline,
  });

  factory CompetitionRegistrationInfoDto.fromMap(String id, Map<String, dynamic> data) {
    return CompetitionRegistrationInfoDto(
      id: id,
      adherentId: data['adherentId'],
      competitionId: data['competitionId'],
      registrationDeadline: (data['registrationDeadline'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adherentId': adherentId,
      'competitionId': competitionId,
      'registrationDeadline': Timestamp.fromDate(registrationDeadline),
    };
  }

  CompetitionRegistration toEntity() {
    return CompetitionRegistration(
      id: id,
      adherentId: adherentId,
      competitionId: competitionId,
    );
  }
}
