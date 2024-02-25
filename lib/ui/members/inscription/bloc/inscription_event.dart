abstract class InscriptionEvent {}

class InscriptionSignUpEvent extends InscriptionEvent {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String email;
  final String password;
  final Function navigateToAccount;

  InscriptionSignUpEvent({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.email,
    required this.password,
    required this.navigateToAccount,
  });
}
