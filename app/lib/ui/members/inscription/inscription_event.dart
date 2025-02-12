abstract class InscriptionEvent {}

class InscriptionSignUpEvent extends InscriptionEvent {
  final String id;
  final String email;
  final String password;
  final Function navigateToAccount;

  InscriptionSignUpEvent({
    required this.id,
    required this.email,
    required this.password,
    required this.navigateToAccount,
  });
}
