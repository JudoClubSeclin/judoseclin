import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String titre;
  final String contenu;
  final DateTime publication;

  const News({
    required this.titre,
    required this.contenu,
    required this.publication,
  });

  factory News.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, String id) {
    final data = snapshot.data();

    return News(
      titre: data?['titre'],
      contenu: data?['contenu'],
      publication: data?['date_publication'].toDate(),
    );
  }

  String toMarkdownText() {
    String md = "";
    md += "# $titre\n\n";
    md += "_${publication.toString()}_\n\n";
    md += contenu;
    return md;
  }
}
