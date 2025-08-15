import '../../../domain/entities/competition_registration.dart';

abstract class CompetitionRegistrationState {}

class CompetitionRegistrationInitial extends CompetitionRegistrationState {}

class CompetitionRegistrationLoading extends CompetitionRegistrationState {}

class CompetitionRegistrationSuccess extends CompetitionRegistrationState {}

class CompetitionRegistrationFailure extends CompetitionRegistrationState {
  final String message;

  CompetitionRegistrationFailure(this.message);
}

class AdherentRegistrationsLoaded extends CompetitionRegistrationState {
  final List<CompetitionRegistration> registrations;

  AdherentRegistrationsLoaded(this.registrations);
}

class RegistrationStatusChecked extends CompetitionRegistrationState {
  final bool isRegistered;
  RegistrationStatusChecked(this.isRegistered);
}
