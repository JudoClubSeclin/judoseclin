import 'package:cloud_firestore/cloud_firestore.dart';

class InscriptionCompetition {
  final String
      id; // ID de l'inscription (utile si vous voulez le stocker, sinon vous pouvez l'ignorer)
  final String userId;
  final String competitionId;
  final DateTime timestamp;

  InscriptionCompetition({
    required this.id,
    required this.userId,
    required this.competitionId,
    required this.timestamp,
  });

  factory InscriptionCompetition.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InscriptionCompetition(
      id: doc.id,
      userId: data['userId'] ?? '',
      competitionId: data['competitionId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
