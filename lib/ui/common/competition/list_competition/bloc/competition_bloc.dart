import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../interactor/competition_interactor.dart';
import 'competition_event.dart';
import 'competition_state.dart';

class CompetitionBloc extends Bloc<CompetitionEvent, CompetitionState> {
  final CompetitionInteractor competitionInteractor;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CompetitionBloc(this.competitionInteractor) : super(CompetitionLoading());

  Stream<CompetitionState> mapEventToState(CompetitionEvent event) async* {
    if (event is LoadCompetitions) {
      yield CompetitionLoading();
      try {
        final competition = await competitionInteractor.fetchCompetitionData();
        yield CompetitionLoaded(competitionData: competition);
      } catch (e) {
        yield CompetitionError(message: 'Une erreur s\'est produite : $e');
      }
    }
  }
}