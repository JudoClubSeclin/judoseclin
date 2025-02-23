import 'package:flutter/material.dart';

abstract class InscriptionCompetitionEvent {}

class LoadInscriptionCompetition extends InscriptionCompetitionEvent {}

class ValidationInscription extends InscriptionCompetitionEvent {
  final String id;

  ValidationInscription(this.id);
}

class RegisterForCompetition extends InscriptionCompetitionEvent {
  final String userId;
  final String competitionId;

  RegisterForCompetition({required this.userId, required this.competitionId});
}

class InscriptionCompetitionSuccess extends InscriptionCompetitionEvent {
  final BuildContext? context;

  InscriptionCompetitionSuccess({this.context});
}

class LoadUserInscriptions extends InscriptionCompetitionEvent {
  final String userId;

  LoadUserInscriptions(this.userId);
}
