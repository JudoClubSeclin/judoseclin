// login_state.dart

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});
}

class PasswordResetInProgress extends LoginState {}

class PasswordResetSuccess extends LoginState {}

class PasswordResetFailure extends LoginState {
  final String error;

  PasswordResetFailure({required this.error});
}
