abstract class CompetitionRegistrationEvent {}

class RegisterToCompetitionEvent extends CompetitionRegistrationEvent {
  final String adherentId;
  final String competitionId;
  final DateTime competitionDate;

  RegisterToCompetitionEvent({
    required this.adherentId,
    required this.competitionId,
    required this.competitionDate,
  });
}

class LoadAdherentRegistrationsEvent extends CompetitionRegistrationEvent {
  final String adherentId;

  LoadAdherentRegistrationsEvent(this.adherentId);
}

class CheckRegistrationStatusEvent extends CompetitionRegistrationEvent {
  final String adherentId;
  final String competitionId;

  CheckRegistrationStatusEvent({
    required this.adherentId,
    required this.competitionId,
  });
}
