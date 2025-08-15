import 'package:cloud_firestore/cloud_firestore.dart';

class CompetitionRegistration {
  final String id;
  final String adherentId;
  final String competitionId;

  CompetitionRegistration({
    required this.id,
    required this.adherentId,
    required this.competitionId,
  });

  factory CompetitionRegistration.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return CompetitionRegistration(
      id: doc.id,
      adherentId: data['adherentId'],
      competitionId: data['competitionId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adherentId': adherentId,
      'competitionId': competitionId,
    };
  }
}
