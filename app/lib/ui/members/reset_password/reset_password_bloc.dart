import 'package:flutter_bloc/flutter_bloc.dart';
import '../interactor/users_interactor.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final UsersInteractor usersInteractor;

  ResetPasswordBloc(this.usersInteractor) : super(ResetPasswordInitial()) {
    on<ResetPasswordRequested>((event, emit) async {
      emit(ResetPasswordLoading());
      try {
        await usersInteractor.resetPassword(event.email);
        emit(ResetPasswordSuccess());
      } catch (error) {
        emit(ResetPasswordFailure(error.toString()));
      }
    });
  }
}
