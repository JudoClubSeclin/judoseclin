import 'package:bloc/bloc.dart';

import '../interactor/adherents_interactor.dart';
import 'adherents_event.dart';
import 'adherents_state.dart';

class AdherentsBloc extends Bloc<AdherentsEvent, AdherentsState> {
  final AdherentsInteractor adherentsInteractor;

  AdherentsBloc(this.adherentsInteractor) : super(SignUpInitialState()) {
    on<AdherentsEvent>((event, emit) async {
      if (event is SignUpEvent) {
        emit(SignUpLoadingState());
        try {
          await adherentsInteractor.addAdherents(
            event.id,
            event.firstName,
            event.lastName,
            event.email,
            event.dateOfBirth,
            event.licence,
            event.belt,
            event.discipline,
            event.category,
            event.tutor,
            event.phone,
            event.address,
            event.image,
            event.sante,
            event.medicalCertificate,
            event.invoice,
            event.payement,
          );
          emit(SignUpSuccessState());
        } catch (error) {
          emit(SignUpErrorState(error.toString()));
        }
      }
    });
  }
}
