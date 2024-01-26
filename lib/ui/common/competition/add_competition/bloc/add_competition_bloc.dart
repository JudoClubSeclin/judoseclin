import 'package:bloc/bloc.dart';

import '../interactor/add_competition_interactor.dart';
import 'add_competition_event.dart';
import 'add_competition_state.dart';

class AddCompetitionBloc
    extends Bloc<AddCompetitionEvent, AddCompetitionState> {
  final AddCompetitionInteractor addCompetitionInteractor;

  AddCompetitionBloc(this.addCompetitionInteractor)
      : super(AddCompetitionSignUpInitialState()) {
    on<AddCompetitionEvent>((event, emit) async {
      if (event is AddCompetitionSignUpEvent) {
        emit(AddCompetitionSignUpLoadingState());
        try {
          await addCompetitionInteractor.addCompetition(
              event.id,
              event.address,
              event.title,
              event.subtitle,
              event.date as String,
              event.poussin,
              event.benjamin,
              event.minime);
          emit(AddCompetitionSignUpSuccessState(addCompetitionId: event.id));
        } catch (error) {
          emit(AddCompetitionSignUpErrorState(error.toString()));
        }
      }
    });
  }
}
