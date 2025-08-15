import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/competition_repository.dart';
import '../../../domain/entities/competition.dart';
import 'competition_event.dart';
import 'competition_state.dart';

class CompetitionBloc extends Bloc<CompetitionEvent, CompetitionState> {
  final CompetitionRepository competitionRepository;

  CompetitionBloc(this.competitionRepository) : super(CompetitionLoadingState()) {
    // Charger la liste
    on<LoadCompetitions>((event, emit) async {
      emit(CompetitionLoadingState());
      try {
        final competitionsStream = competitionRepository.getCompetitionStream();
        await emit.forEach<List<Competition>>(
          competitionsStream,
          onData: (competitions) => CompetitionLoadedState(competitions: competitions),
          onError: (error, stackTrace) => CompetitionErrorState(message: error.toString()),
        );
      } catch (e) {
        emit(CompetitionErrorState(message: e.toString()));
      }
    });

    // Charger le détail
    on<FetchCompetitionDetail>((event, emit) async {
      emit(CompetitionLoadingState());
      try {
        final competition = await competitionRepository.getById(event.competitionId);
        if (competition != null) {
          emit(CompetitionDetailLoadedState(competition: competition));
        } else {
          emit(CompetitionErrorState(message: 'Compétition introuvable'));
        }
      } catch (e) {
        emit(CompetitionErrorState(message: e.toString()));
      }
    });
  }
}
