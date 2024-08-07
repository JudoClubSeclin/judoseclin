import 'package:bloc/bloc.dart';
import 'package:judoseclin/domain/entities/adherents.dart';

import '../interactor/adherents_interactor.dart';
import 'adherents_event.dart';
import 'adherents_state.dart';

class AdherentsBloc extends Bloc<AdherentsEvent, AdherentsState> {
  final AdherentsInteractor adherentsInteractor;
  final String adherentId;

  AdherentsBloc(this.adherentsInteractor, {required this.adherentId})
      : super(SignUpInitialState()) {
    on<AdherentsEvent>((event, emit) async {
      if (event is AddAdherentsSignUpEvent) {
        emit(SignUpLoadingState());
        try {
          DateTime parsedDate = DateTime.parse(event.dateOfBirth.toString());

          final adherents = Adherents(
            id: event.id,
            firstName: event.firstName,
            lastName: event.lastName,
            email: event.email,
            dateOfBirth: parsedDate,
            licence: event.licence,
            blet: event.blet,
            discipline: event.discipline,
            category: event.category,
            tutor: event.tutor,
            phone: event.phone,
            address: event.address,
            image: event.image,
            sante: event.sante,
            medicalCertificate: event.medicalCertificate,
            invoice: event.invoice,
          );
          await adherentsInteractor.addAdherents(adherents);
          emit(SignUpSuccessState(adherentId: adherentId));
        } catch (error) {
          emit(SignUpErrorState(error.toString()));
        }
      }
    });
  }
}
