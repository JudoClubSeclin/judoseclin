
import '../../domain/entities/competition.dart';

abstract class CompetitionRepository {
  Stream<Iterable<Competition>> getCompetitionStream();
  Future<Map<String, dynamic>> getById(String competitionId);
  Future<void> add(Map<String, dynamic> data);
  Future<void> updateField(
      String competitionId, String fieldName, String newValue);
}


