import '../../data/repository/competition_registration_repository.dart';
import '../entities/competition_registration.dart';

class RegisterToCompetitionUseCase {
  final CompetitionRegistrationRepository repository;

  RegisterToCompetitionUseCase(this.repository);

  Future<void> call(CompetitionRegistration registration) async {
    await repository.registerToCompetition(registration);
  }
}

class GetAdherentRegistrationsUseCase {
  final CompetitionRegistrationRepository repository;

  GetAdherentRegistrationsUseCase(this.repository);

  Future<List<CompetitionRegistration>> call(String adherentId) {
    return repository.getRegistrationsForAdherent(adherentId);
  }
}
