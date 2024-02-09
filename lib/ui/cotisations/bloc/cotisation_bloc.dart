import 'package:bloc/bloc.dart';
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
      if (event is CotisationSignUpEvent) {
        emit(CotisationSignUpLoadingState());
        try {
          await cotisationInteractor.addCotisation(
              event.id,
              event.adherentId,
              event.amount,
              event.date,
              event.cheques.cast<Cheque>(),
              event.bankName);
          emit(CotisationSignUpSuccessState());
        } catch (error) {
          emit(CotisationSignUpErrorState(error.toString()));
        }
      }
    });
  }
}
