import 'package:cloud_firestore/cloud_firestore.dart';

class InscriptionCompetition {
  final String id;
  final String userId;
  final String competitionId;
  final DateTime? timestamp;
  final bool validated;

  InscriptionCompetition(
      {required this.id,
      required this.userId,
      required this.competitionId,
       this.timestamp,
      this.validated = false});

  factory InscriptionCompetition.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InscriptionCompetition(
      id: doc.id,
      userId: data['userId'],
      competitionId: data['competitionId'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}
