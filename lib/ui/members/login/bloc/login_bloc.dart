// login_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:judoseclin/ui/members/interactor/users_interactor.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UsersInteractor usersInteractor;
  final userId;

  LoginBloc(this.usersInteractor, {required this.userId})
      : super(LoginInitial()) {
    on<LoginWithEmailPassword>((event, emit) async {
      emit(LoginLoading());
      try {
        await usersInteractor.login(event.email, event.password);
        event.navigateToAccount();
        emit(LoginSuccess());
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(PasswordResetInProgress());
      try {
        await usersInteractor.resetPassword(event.email);
        emit(PasswordResetSuccess());
      } catch (error) {
        emit(PasswordResetFailure(error: error.toString()));
      }
    });
  }
}
