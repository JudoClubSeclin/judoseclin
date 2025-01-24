import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String titre;
  final String details;
  final DateTime datePublication;

  const News({
    required this.titre,
    required this.details,
    required this.datePublication,
  });

  /// Factory method to create a `News` instance from Firestore data.
  factory News.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw Exception('Snapshot data is null');
    }

    return News(
      titre: data['titre'] as String,
      details: data['contenu'] as String,
      datePublication: (data['date_publication'] as Timestamp).toDate(),
    );
  }

  /// Converts the `News` instance into a Markdown string.
  String toMarkdownText() {
    return '''
# $titre

_${datePublication.toLocal()}_

$details
    ''';
  }
}
