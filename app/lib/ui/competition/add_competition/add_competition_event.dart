abstract class AddCompetitionEvent {}

class AddCompetitionSignUpEvent extends AddCompetitionEvent {
  final String id;
  final String address;
  final String title;
  final String subtitle;
  final DateTime date;
  final DateTime? publishDate;
  final String poussin;
  final String benjamin;
  final String minime;
  final String cadet;
  final String juniorSenior;
  final String minBeltPoussin;
  final String minBeltBenjamin;
  final String minBeltMinime;
  final String minBeltCadet;
  final String minBeltJuniorSenior;

  AddCompetitionSignUpEvent({
    required this.id,
    required this.address,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.publishDate,
    required this.poussin,
    required this.benjamin,
    required this.minime,
    required this.cadet,
    required this.juniorSenior,
    required this.minBeltPoussin,
    required this.minBeltBenjamin,
    required this.minBeltMinime,
    required this.minBeltCadet,
    required this.minBeltJuniorSenior,
  });
}
