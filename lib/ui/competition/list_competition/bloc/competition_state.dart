import '../../../../../domain/entities/competition.dart';

abstract class CompetitionState {}

class CompetitionLoading extends CompetitionState {}

class CompetitionLoaded extends CompetitionState {
  final List<Competition> competitionData;

  CompetitionLoaded({required this.competitionData});
}

class CompetitionError extends CompetitionState {
  final String message;

  CompetitionError({required this.message});
}
