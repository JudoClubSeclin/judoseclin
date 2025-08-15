import '../../domain/entities/competition.dart';

abstract class CompetitionRepository {
  Stream<List<Competition>> getCompetitionStream();
  Future<Map<String, String>> getCompetitionTitles(List<String> competitionIds);
  Future<Competition?> getById(String competitionId);
  Future<void> add(Map<String, dynamic> data);
  Future<void> updateField(
    String competitionId,
    String fieldName,
    String newValue,
  );
}
