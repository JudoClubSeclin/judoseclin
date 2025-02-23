import 'package:flutter_bloc/flutter_bloc.dart';

import 'competition_interactor.dart';
import 'competition_event.dart';
import 'competition_state.dart';

class CompetitionBloc extends Bloc<CompetitionEvent, CompetitionState> {
  final CompetitionInteractor competitionInteractor;

  CompetitionBloc(this.competitionInteractor, {required String competitionId})
    : super(CompetitionSignUpLoadingState());

  Stream<CompetitionState> mapEventToState(CompetitionEvent event) async* {
    if (event is LoadCompetitions) {
      yield CompetitionSignUpLoadingState();
      try {
        final competition = await competitionInteractor.fetchCompetitionData();

        // Convertir l'itérable en une liste
        final competitionList = competition.toList();

        yield CompetitionSignUpLoadedState(competitionData: competitionList);
      } catch (e) {
        yield CompetitionSignUpErrorState(
          message: 'Une erreur s\'est produite : $e',
        );
      }
    }
  }
}
