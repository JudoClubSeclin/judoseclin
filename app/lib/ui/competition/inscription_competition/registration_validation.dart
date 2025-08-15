import 'package:judoseclin/core/utils/belt_color_mapper.dart';

class RegistrationValidation {
  /// Vérifie si la ceinture existe bien dans notre système
  static bool isBeltValid(String belt) {
    final beltEn = beltFrToEn(belt.toLowerCase());
    return beltOrder.contains(beltEn);
  }

  /// Vérifie si la catégorie est présente dans les données de la compétition
  static bool isCategoryInCompetition(
      String category,
      Map<String, dynamic> competitionData,
      ) {
    return competitionData.containsKey(category) &&
        competitionData[category] != null;
  }
}
