abstract class AddCompetitionEvent {}

class AddCompetitionSignUpEvent extends AddCompetitionEvent {
  final String id;
  final String address;
  final String title;
  final String subtitle;
  final String date;
  final String poussin;
  final String benjamin;
  final String minime;

  AddCompetitionSignUpEvent(
      {required this.id,
      required this.address,
      required this.title,
      required this.subtitle,
      required this.date,
      required this.poussin,
      required this.benjamin,
      required this.minime});
}
