class CompetitionDto {
  final String id;
  final String address;
  final String title;
  final String subtitle;
  final DateTime date;
  final DateTime publishDate;
  final String? poussin;
  final String? benjamin;
  final String? minime;
  final String? cadet;
  final String? juniorSenior;
  final String? minBeltPoussin;
  final String? minBeltBenjamin;
  final String? minBeltMinime;
  final String? minBeltCadet;
  final String? minBeltJuniorSenior;



  CompetitionDto({
    required this.id,
    required this.address,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.publishDate,
     this.poussin,
     this.benjamin,
     this.minime,
     this.cadet,
     this.juniorSenior,
     this.minBeltPoussin,
     this.minBeltBenjamin,
     this.minBeltMinime,
     this.minBeltCadet,
     this.minBeltJuniorSenior,
  });
}
