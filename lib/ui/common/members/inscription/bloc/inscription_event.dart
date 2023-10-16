abstract class InscriptionEvent {}

class SignUpEvent extends InscriptionEvent {
  final String email;
  final String password;
  final String nom;
  final String prenom;
  final String dateNaissance;

  SignUpEvent({
    required this.email,
    required this.password,
    required this.nom,
    required this.prenom,
    required this.dateNaissance,
  });
}
