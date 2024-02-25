import '../../../../../domain/entities/competition.dart';

abstract class CompetitionState {}

class CompetitionSignUpLoadingState extends CompetitionState {}

class CompetitionSignUpLoadedState extends CompetitionState {
  final List<Competition> competitionData;

  CompetitionSignUpLoadedState({required this.competitionData});
}

class CompetitionSignUpErrorState extends CompetitionState {
  final String message;

  CompetitionSignUpErrorState({required this.message});
}
