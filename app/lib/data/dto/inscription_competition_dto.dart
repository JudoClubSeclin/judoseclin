
class InscriptionCompetitionDto {
  final String id;
  final String userId;
  final String competitionId;
  final DateTime timestamp;
  final bool validated;

  InscriptionCompetitionDto({
    required this.id,
    required this.userId,
    required this.competitionId,
    required this.timestamp,
    this.validated = false
});
}