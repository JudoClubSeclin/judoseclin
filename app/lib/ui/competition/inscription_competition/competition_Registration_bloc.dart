import 'package:flutter_bloc/flutter_bloc.dart';
import 'competition_registration_event.dart';
import 'competition_registration_state.dart';
import 'competition_registration_interactor.dart';
import 'package:flutter/material.dart';

class CompetitionRegistrationBloc
    extends Bloc<CompetitionRegistrationEvent, CompetitionRegistrationState> {
  final CompetitionRegistrationInteractor interactor;

  CompetitionRegistrationBloc(this.interactor)
      : super(CompetitionRegistrationInitial()) {
    on<RegisterToCompetitionEvent>(_onRegister);
    on<LoadAdherentRegistrationsEvent>(_onLoad);
    on<CheckRegistrationStatusEvent>(_onCheckStatus);
  }

  Future<void> _onRegister(
      RegisterToCompetitionEvent event, Emitter emit) async {
    debugPrint("Bloc: _onRegister appelé avec ${event.adherentId} / ${event.competitionId}");
    emit(CompetitionRegistrationLoading());

    try {
      debugPrint("Bloc: Tentative d'inscription en cours...");
      await interactor.register(
        event.adherentId,
        event.competitionId,
        event.competitionDate,
      );
      debugPrint("Bloc: Inscription réussie pour ${event.adherentId}");
      emit(CompetitionRegistrationSuccess());
    } catch (e, st) {
      debugPrint("Bloc: Erreur lors de l'inscription : $e");
      debugPrint("StackTrace : $st");
      emit(CompetitionRegistrationFailure(e.toString()));
    }
  }

  Future<void> _onLoad(
      LoadAdherentRegistrationsEvent event, Emitter emit) async {
    debugPrint("Bloc: _onLoad pour ${event.adherentId}");
    emit(CompetitionRegistrationLoading());

    try {
      final regs = await interactor.getAdherentRegistrations(event.adherentId);
      debugPrint("Bloc: ${regs.length} inscriptions récupérées");
      emit(AdherentRegistrationsLoaded(regs.cast()));
    } catch (e, st) {
      debugPrint("Bloc: Erreur lors du chargement des inscriptions : $e");
      debugPrint("StackTrace : $st");
      emit(CompetitionRegistrationFailure(e.toString()));
    }
  }

  Future<void> _onCheckStatus(
      CheckRegistrationStatusEvent event, Emitter emit) async {
    debugPrint("Bloc: _onCheckStatus pour ${event.adherentId} / ${event.competitionId}");
    emit(CompetitionRegistrationLoading());

    try {
      final registered = await interactor.isAdherentRegistered(
        adherentId: event.adherentId,
        competitionId: event.competitionId,
      );
      debugPrint("Bloc: Status vérifié : $registered");
      emit(RegistrationStatusChecked(registered));
    } catch (e, st) {
      debugPrint("Bloc: Erreur lors de la vérification du statut : $e");
      debugPrint("StackTrace : $st");
      emit(CompetitionRegistrationFailure(e.toString()));
    }
  }
}
