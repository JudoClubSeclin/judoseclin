class Competition {
  final String id;
  final Geocode address;
  final String titre;
  final String sousTitre;
  final DateTime debut;
  final DateTime fin;
  final DateTime limiteInscription;
  final List<String>
      description; // Utilisez le type approprié pour votre description.

  Competition({
    required this.id,
    required this.address,
    required this.titre,
    required this.sousTitre,
    required this.debut,
    required this.fin,
    required this.limiteInscription,
    required this.description,
  });

  //  méthode de conversion statique pour créer une instance de Competition depuis les données Firestore.
  static Competition fromFirestore(Map<String, dynamic> data) {
    final Geocode address = Geocode(
      longitude: data['address']['longitude'],
      latitude: data['address']['latitude'],
    );

    return Competition(
      id: data['id'],
      address: address,
      titre: data['titre'],
      sousTitre: data['sousTitre'],
      debut: data['debut'].toDate(),
      fin: data['fin'].toDate(),
      limiteInscription: data['limiteInscription'].toDate(),
      description: data['description'],
    );
  }
}

class Geocode {
  final double longitude;
  final double latitude;

  Geocode({required this.longitude, required this.latitude});

  // Constructeur de copie
  Geocode.copy(Geocode other)
      : longitude = other.longitude,
        latitude = other.latitude;
}
