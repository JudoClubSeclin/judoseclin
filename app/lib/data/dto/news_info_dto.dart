

class NewsInfoDto {
  final String titre;
  final DateTime publication;
  final String contenu;

  NewsInfoDto({
    required this.titre,
    required this.publication,
    required this.contenu,
  });

  factory NewsInfoDto.fromJson(Map<String, dynamic> json) {
    return NewsInfoDto(
      titre: json['titre'] ?? '',
      contenu: json['contenu'] ?? '',
      publication: (json['datePublication'] ?? json['date_publication'])?.toDate() ?? DateTime.now(),
    );
  }

}
