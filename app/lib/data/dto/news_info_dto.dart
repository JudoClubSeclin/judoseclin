
class NewsInfoDto {
  final String titre;
  final DateTime datePublication;
  final String details;

  NewsInfoDto({
    required this.titre,
    required this.datePublication,
    required this.details,
  });

  factory NewsInfoDto.fromJson(Map<String, dynamic> json) {
    return NewsInfoDto(
        titre: json ['titre'],
        datePublication: json ['datePublication'],
        details: json ['details']
    );
  }
}
