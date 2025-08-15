import 'package:judoseclin/core/di/api/firestore_service.dart';

import '../../domain/entities/competition_registration.dart';
import '../dto/competition_registration_info_dto.dart';
import 'competition_registration_repository.dart';

class CompetitionRegistrationRepositoryImpl implements CompetitionRegistrationRepository {
  final FirestoreService firestore;

  CompetitionRegistrationRepositoryImpl(this.firestore);

  @override
  Future<void> registerToCompetition(CompetitionRegistration registration) async {
    await firestore.collection('competition_registration').add(registration.toMap());
  }

  @override
  Future<List<CompetitionRegistration>> getRegistrationsForAdherent(String adherentId) async {
    final query = await firestore
        .collection('competition_registration')
        .where('adherentId', isEqualTo: adherentId)
        .get();

    return query.docs
        .map((doc) => CompetitionRegistrationInfoDto.fromMap(doc.id, doc.data()).toEntity())
        .toList();
  }

  @override
  Future<bool> isAlreadyRegistered(String adherentId, String competitionId) async {
    final query = await firestore
        .collection('competition_registration')
        .where('adherentId', isEqualTo: adherentId)
        .where('competitionId', isEqualTo: competitionId)
        .get();

    return query.docs.isNotEmpty;
  }
}
