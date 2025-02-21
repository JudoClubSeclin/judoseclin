import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/users.dart';
import '../interactor/users_interactor.dart';
import 'inscription_event.dart';
import 'inscription_state.dart';

class InscriptionBloc extends Bloc<InscriptionEvent, InscriptionState> {
  final UsersInteractor usersInteractor;
  final String userId;

  InscriptionBloc(
    this.usersInteractor, {
    required this.userId,
  }) : super(SignUpInitialState()) {
    on<InscriptionSignUpEvent>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        final users = Users(
          id: event.id,
          email: event.email,
          password: event.password,
        );
        event.navigateToAccount();
        await usersInteractor.registerUser(users);
        emit(SignUpSuccessState(userId: ''));
      } catch (error) {
        emit(SignUpErrorState(error.toString()));
      }
    });
  }
}
