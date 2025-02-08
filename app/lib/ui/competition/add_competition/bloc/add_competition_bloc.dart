import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/domain/entities/competition.dart';

import '../../list_competition/competition_interactor.dart';
import 'add_competition_event.dart';
import 'add_competition_state.dart';

class AddCompetitionBloc
    extends Bloc<AddCompetitionEvent, AddCompetitionState> {
  final CompetitionInteractor competitionInteractor;

  AddCompetitionBloc(this.competitionInteractor)
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

          final competition = Competition(
            id: event.id,
            address: event.address,
            title: event.title,
            subtitle: event.subtitle,
            date: parsedDate,
            publishDate: parsedPublishDate,
            poussin: event.poussin,
            benjamin: event.benjamin,
            minime: event.minime,
            cadet: event.cadet,
            juniorSenior: event.juniorSenior,
          );

          await competitionInteractor.addCompetition(competition);
          emit(AddCompetitionSignUpSuccessState(addCompetitionId: event.id));
        } catch (error) {
          emit(AddCompetitionSignUpErrorState(error.toString()));
        }
      }
    });
  }
}
