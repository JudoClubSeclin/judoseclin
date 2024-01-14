import 'package:bloc/bloc.dart';
import 'package:judoseclin/ui/common/cotisations/bloc/Cotisation_Event.dart';
import 'package:judoseclin/ui/common/cotisations/bloc/Cotisation_sate.dart';

import '../interactor/cotisation_interactor.dart';

class CotisationBloc extends Bloc<CotisationEvent, CotisationState> {
  final CotisationInteractor cotisationInteractor;
  final String adherentId;

  CotisationBloc({required this.cotisationInteractor, required this.adherentId})
      : super(SignUpInitialState()) {
    on<CotisationEvent>((event, emit) async {
      if (event is CotisationSignUpEvent) {
        emit(SignUpLoadingState());
        try {
          await cotisationInteractor.addCotisation(
              event.adherentId,
              event.amount,
              event.date,
              event.chequeNumber,
              event.chequeAmount,
              event.bankName);
          emit(SignUpSuccessState());
        } catch (error) {
          emit(SignUpErrorState(error.toString()));
        }
      }
    });
  }
}
