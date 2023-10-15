abstract class LoginEvent {}

class LoginWithEmailPassword extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmailPassword({required this.email, required this.password});
}
