import 'package:judoseclin/domain/entities/cotisation.dart';

abstract class CotisationRepository {
  Stream<Iterable<Cotisation>> getCotisationStream();
  Future<Map<String, dynamic>?> getById(String cotisationId);
  Stream<Iterable<Cotisation>> getCotisationsByAdherentId(String adherentId);
  Future<void> add(Map<String, dynamic> data, String documentId);

  Future<void> updateField(
    String cotisationId,
    String fieldName,
    String newValue,
  );
}
