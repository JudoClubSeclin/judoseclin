import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

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
          debugPrint('Date avant conversion: ${event.date}');
          debugPrint('Publish Date avant conversion: ${event.publishDate}');

          // Convertir les dates au besoin
          DateTime parsedDate = DateTime.parse(event.date.toString());
          DateTime parsedPublishDate =
              DateTime.parse(event.publishDate.toString());

          debugPrint('Date après conversion: $parsedDate');
          debugPrint('Publish Date après conversion: $parsedPublishDate');

          await addCompetitionInteractor.addCompetition(
            event.id,
            event.address,
            event.title,
            event.subtitle,
            parsedDate,
            parsedPublishDate,
            event.poussin,
            event.benjamin,
            event.minime,
            event.cadet,
            event.juniorSenior,
          );
          emit(AddCompetitionSignUpSuccessState(addCompetitionId: event.id));
        } catch (error) {
          emit(AddCompetitionSignUpErrorState(error.toString()));
        }
      }
    });
  }
}
