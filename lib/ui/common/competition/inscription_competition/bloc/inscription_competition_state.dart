abstract class InscriptionCompetitionState {}

class InscriptionCompetitionInitial extends InscriptionCompetitionState {}

class InscriptionCompetitionProgress extends InscriptionCompetitionState {}

class InscriptionCompetitionError extends InscriptionCompetitionState {
  final String errorMessage;
  InscriptionCompetitionError(this.errorMessage);
}

class InscriptionCompetitionClosed extends InscriptionCompetitionState {}

class InscriptionCompetitionSuccessState extends InscriptionCompetitionState {}
