import 'package:flutter_bloc/flutter_bloc.dart';

import '../interactor/inscription_interactor.dart';
import 'inscription_event.dart';
import 'inscription_state.dart';

class InscriptionBloc extends Bloc<InscriptionEvent, InscriptionState> {
  final InscriptionInteractor inscriptionInteractor;

  InscriptionBloc(this.inscriptionInteractor) : super(SignUpInitialState()) {
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        await inscriptionInteractor.signUpToFirebase(
          event.nom,
          event.prenom,
          event.dateNaissance,
          event.email,
          event.password,
        );
        event.navigateToAccount();
        emit(SignUpSuccessState());
      } catch (error) {
        emit(SignUpErrorState(error.toString()));
      }
    });
  }
}
