import '../../domain/entities/competition_registration.dart';

abstract class CompetitionRegistrationRepository {
  Future<void> registerToCompetition(CompetitionRegistration registration);
  Future<List<CompetitionRegistration>> getRegistrationsForAdherent(String adherentId);
  Future<bool> isAlreadyRegistered(String adherentId, String competitionId);
}
