
class InscriptionCompetitionInfoDto {
  final String id;
  final String userId;
  final String competitionId;
  final DateTime timestamp;
  final bool validated;

  InscriptionCompetitionInfoDto({
    required this.id,
    required this.userId,
    required this.competitionId,
    required this.timestamp,
    this.validated = false
});

  factory InscriptionCompetitionInfoDto.fromJson(Map<String, dynamic> json) {
    return InscriptionCompetitionInfoDto(
        id:json ['id'],
        userId:json ['userId'],
        competitionId: json ['competitionId'],
        timestamp: json ['timestamp']
    );
  }
}