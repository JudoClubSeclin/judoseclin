
import '../../domain/entities/adherents.dart';

abstract class AdherentsRepository {


  Stream<Iterable<Adherents>> getAdherentsStream();
  Future<Map<String, dynamic>?> getById(String adherentsId);
  Future<void> add(Map<String, dynamic> data);
  Future<void> updateField(
      String adherentId, String fieldName, String newValue);
}


