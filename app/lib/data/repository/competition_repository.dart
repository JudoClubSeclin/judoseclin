import '../../domain/entities/competition.dart';

abstract class CompetitionRepository {
  Stream<Iterable<Competition>> getCompetitionStream();
  Future<List<String>> getUserCompetitionIds(String userId);
  Future<Map<String, String>> getCompetitionTitles(List<String> competitionIds);
  Future<Map<String, dynamic>> getById(String competitionId);
  Future<void> add(Map<String, dynamic> data);
  Future<void> updateField(
    String competitionId,
    String fieldName,
    String newValue,
  );
}
