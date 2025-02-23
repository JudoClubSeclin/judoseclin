abstract class UserEvent {}

class FetchUserDataEvent extends UserEvent {}

class LoginWithEmailPassword extends UserEvent {
  final String email;
  final String password;
  final Function navigateToAccount;

  LoginWithEmailPassword({
    required this.email,
    required this.password,
    required this.navigateToAccount,
  });
}

class LogOutEvent extends UserEvent {}
