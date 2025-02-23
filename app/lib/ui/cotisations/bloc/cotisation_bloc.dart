import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';

import '../interactor/cotisation_interactor.dart';
import 'cotisation_event.dart';
import 'cotisation_sate.dart';

class CotisationBloc extends Bloc<CotisationEvent, CotisationState> {
  final CotisationInteractor cotisationInteractor;
  final String adherentId;

  CotisationBloc({required this.cotisationInteractor, required this.adherentId})
    : super(CotisationSignUpInitialState()) {
    on<CotisationEvent>((event, emit) async {
      if (event is AddCotisationSignUpEvent) {
        emit(CotisationSignUpLoadingState());
        try {
          final cotisation = Cotisation(
            id: event.id,
            adherentId: event.adherentId,
            amount: event.amount,
            date: event.date,
            cheques: event.cheques.cast<Cheque>(),
            bankName: event.bankName,
          );
          await cotisationInteractor.addCotisation(cotisation);
          debugPrint('je suis le bloc');
          emit(CotisationSignUpSuccessState(adherentId: adherentId));
        } catch (error) {
          emit(CotisationSignUpErrorState(error.toString()));
        }
      }
    });
  }
}
