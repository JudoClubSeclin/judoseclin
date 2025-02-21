// load_competitions.dart

import 'package:equatable/equatable.dart';

abstract class CompetitionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadCompetitions extends CompetitionEvent {}

class FetchCompetitionDetail extends CompetitionEvent {
  final String competitionId;

  FetchCompetitionDetail(this.competitionId);

  @override
  List<Object> get props => [competitionId];
}
