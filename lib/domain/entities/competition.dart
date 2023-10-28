class Competition {
  final Geocode position;
  final String titre;
  final String sousTitre;
  final DateTime dateDebut;
  final DateTime dateFin;
  final DateTime limiteInscription;
  final String description;

  Competition({
    required this.position,
    required this.titre,
    required this.sousTitre,
    required this.dateDebut,
    required this.dateFin,
    required this.limiteInscription,
    required this.description,
  });
}

class Geocode {
  final double longitude;
  final double latitude;

  Geocode({required this.longitude, required this.latitude});
}
