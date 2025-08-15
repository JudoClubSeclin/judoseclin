import '../../../../domain/entities/competition.dart';

abstract class CompetitionState {}

class CompetitionLoadingState extends CompetitionState {}

class CompetitionLoadedState extends CompetitionState {
  final List<Competition> competitions;
  CompetitionLoadedState({required this.competitions});
}

class CompetitionDetailLoadedState extends CompetitionState {
  final Competition competition;
  CompetitionDetailLoadedState({required this.competition});
}

class CompetitionErrorState extends CompetitionState {
  final String message;
  CompetitionErrorState({required this.message});
}
