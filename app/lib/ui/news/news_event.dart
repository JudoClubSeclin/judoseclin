
abstract class NewsEvent {}

class AddNewsSignUpEvent extends NewsEvent {
  final String id;
  final String titre;
  final String contenu;
  final DateTime publication;

  AddNewsSignUpEvent({
    required this.id,
    required this.titre,
    required this.contenu,
    required this.publication
});
}
