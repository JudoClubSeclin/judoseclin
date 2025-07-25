import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/repository/adherents_repository.dart';
import 'package:judoseclin/domain/entities/adherents.dart';


@injectable
class FetchAdherentsDataUseCase {
  final AdherentsRepository adherentsRepository;

  FetchAdherentsDataUseCase(this.adherentsRepository);

  Future<Iterable<Adherents>> getAdherents() async {
    try {
      debugPrint('Fetching adherents data');
      Stream<Iterable<Adherents>> adherentsStream =
          adherentsRepository.getAdherentsStream();
      List<Adherents> adherentsList = [];
      await for (var adherentIterable in adherentsStream){
        adherentsList.addAll(adherentIterable);
      }
      return adherentsList;
    } catch (e) {
      debugPrint('Error fetching adherents data: $e');
      return [];
    }
  }

  Future<Adherents?> getAdherentsById(String adherentsId) async {
    try {
      debugPrint("Fetching adherents data...");

      Map<String, dynamic>? adherentsData = await adherentsRepository.getById(
        adherentsId,
      );

      // Utiliser la méthode fromMap pour créer une instance Adherents
      return adherentsData != null
          ? Adherents.fromMap(adherentsData, adherentsId)
          : null;
    } catch (e) {
      debugPrint('Error fetching adherents by ID: $e');
      rethrow;
    }
  }



  Future<List<Adherents>> call(String familyId) {
    return adherentsRepository.getAdherentsByFamilyId(familyId);
  }
  Future<List<Adherents>> getAdherentsByFamilyId(String familyId) {
    return adherentsRepository.getAdherentsByFamilyId(familyId);
  }


}
