import 'package:bloc/bloc.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';
import 'package:judoseclin/ui/common/cotisations/bloc/cotisation_event.dart';
import 'package:judoseclin/ui/common/cotisations/bloc/cotisation_sate.dart';

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
              event.id,
              event.adherentId,
              event.amount,
              event.date,
              event.cheques.cast<Cheque>(),
              event.bankName);
          emit(SignUpSuccessState());
        } catch (error) {
          emit(SignUpErrorState(error.toString()));
        }
      }
    });
  }
}
