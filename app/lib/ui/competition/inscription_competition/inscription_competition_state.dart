import '../../../domain/entities/competition.dart';

abstract class InscriptionCompetitionState {}

class InscriptionCompetitionInitial extends InscriptionCompetitionState {}

class InscriptionCompetitionProgress extends InscriptionCompetitionState {}

class InscriptionCompetitionError extends InscriptionCompetitionState {
  final String errorMessage;
  InscriptionCompetitionError(this.errorMessage);
}

class InscriptionCompetitionLoading extends InscriptionCompetitionState {}

class InscriptionCompetitionLoaded extends InscriptionCompetitionState {
  final List<Competition> inscriptions;

  InscriptionCompetitionLoaded(List<Competition> inscriptions)
      : inscriptions = inscriptions.toSet().toList();
}

class InscriptionCompetitionClosed extends InscriptionCompetitionState {}

class InscriptionCompetitionSuccessState extends InscriptionCompetitionState {}