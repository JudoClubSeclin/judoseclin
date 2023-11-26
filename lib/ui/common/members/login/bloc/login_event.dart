abstract class LoginEvent {}

class LoginWithEmailPassword extends LoginEvent {
  final String email;
  final String password;
  final Function navigateToAccount;

  LoginWithEmailPassword(
      {required this.email,
      required this.password,
      required this.navigateToAccount});
}

class ResetPasswordRequested extends LoginEvent {
  final String email;

  ResetPasswordRequested({required this.email});
}
