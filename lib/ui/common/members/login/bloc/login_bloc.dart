import 'package:bloc/bloc.dart';

import '../interactor/login_interactor.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginInteractor loginInteractor;

  LoginBloc({required this.loginInteractor}) : super(LoginInitial()) {
    on<LoginWithEmailPassword>((event, emit) async {
      emit(LoginLoading());
      try {
        await loginInteractor.login(event.email, event.password);
        event.navigateToAccount();
        emit(LoginSuccess());
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });

    // Ajoutez cette partie pour gérer l'événement de réinitialisation du mot de passe
    on<ResetPasswordRequested>((event, emit) async {
      emit(PasswordResetInProgress());
      try {
        await loginInteractor.resetPassword(event.email);
        emit(PasswordResetSuccess());
      } catch (error) {
        emit(PasswordResetFailure(error: error.toString()));
      }
    });
  }
}
