import 'package:bloc/bloc.dart';

import '../interactor/adherents_interactor.dart';
import 'adherents_event.dart';
import 'adherents_state.dart';

class AdherentsBloc extends Bloc<AdherentsEvent, AdherentsState> {
  final AdherentsInteractor adherentsInteractor;
  final String adherentId;

  AdherentsBloc(this.adherentsInteractor, {required this.adherentId})
      : super(SignUpInitialState()) {
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
            event.blet,
            event.discipline,
            event.category,
            event.tutor,
            event.phone,
            event.address,
            event.image,
            event.sante,
            event.medicalCertificate,
            event.invoice,
          );
          emit(SignUpSuccessState(adherentId: adherentId));
        } catch (error) {
          emit(SignUpErrorState(error.toString()));
        }
      }
    });
  }
}
