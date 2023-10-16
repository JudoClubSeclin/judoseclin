import 'package:flutter_bloc/flutter_bloc.dart';

import '../interactor/inscription_interactor.dart';
import 'inscription_event.dart';
import 'inscription_state.dart';

class InscriptionBloc extends Bloc<InscriptionEvent, InscriptionState> {
  final InscriptionInteractor inscriptionInteractor;

  InscriptionBloc(this.inscriptionInteractor) : super(SignUpInitialState());

  @override
  Stream<InscriptionState> mapEventToState(InscriptionEvent event) async* {
    if (event is SignUpEvent) {
      yield SignUpLoadingState();
      try {
        await inscriptionInteractor.signUpToFirebase(
          event.nom,
          event.prenom,
          event.dateNaissance,
          event.email,
          event.password,
        );
        yield SignUpSuccessState();
      } catch (error) {
        yield SignUpErrorState(error.toString());
      }
    }
  }
}
