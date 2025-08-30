import '../../core/utils/belt_color_mapper.dart';
import '../entities/competition.dart';
import '../entities/adherents.dart';

class ValidateCompetitionRegistrationUseCase {
  bool call({
    required Competition competition,
    required Adherents adherent,
  }) {
    final category = adherent.category?.toLowerCase();
    if (category == null) return false;

    String? minBelt;
    switch (category) {
      case 'poussin':
        if (competition.poussin == null) return false;
        minBelt = competition.minBeltPoussin;
        break;
      case 'benjamin':
        if (competition.benjamin == null) return false;
        minBelt = competition.minBeltBenjamin;
        break;
      case 'minime':
        if (competition.minime == null) return false;
        minBelt = competition.minBeltMinime;
        break;
      case 'cadet':
        if (competition.cadet == null) return false;
        minBelt = competition.minBeltCadet;
        break;
      case 'junior':
      case 'senior':
        if (competition.juniorSenior == null) return false;
        minBelt = competition.minBeltJuniorSenior;
        break;
      default:
        return false;
    }

    if (minBelt == null || adherent.belt == null) return false;

    final adherentBeltEn = beltFrToEn(adherent.belt!.toLowerCase());
    final minBeltEn = beltFrToEn(minBelt.toLowerCase());

    final adherentIndex = beltOrder.indexOf(adherentBeltEn);
    final minIndex = beltOrder.indexOf(minBeltEn);

    if (adherentIndex == -1 || minIndex == -1) return false;

    return adherentIndex >= minIndex;
  }
}
