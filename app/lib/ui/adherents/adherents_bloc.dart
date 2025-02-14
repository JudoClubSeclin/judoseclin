import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/core/di/api/auth_service.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';

import 'adherents_state.dart';
import 'interactor/adherents_interactor.dart';
import 'adherents_event.dart';

class AdherentsBloc extends Bloc<AdherentsEvent, AdherentsState> {
  final AdherentsInteractor adherentsInteractor;
  final String adherentId;
  final AuthService _authService;
  final FirestoreService _firestoreService;

  AdherentsBloc(this.adherentsInteractor, this._authService, this._firestoreService, {required this.adherentId})
      : super(SignUpInitialState()) {
    on<AddAdherentsSignUpEvent>(_onAddAdherentsSignUp);
  }

  Future<void> _onAddAdherentsSignUp(
      AddAdherentsSignUpEvent event,
      Emitter<AdherentsState> emit,
      ) async {
    emit(SignUpLoadingState());
    try {
      if (event.email.isEmpty) {
        emit(SignUpErrorState("L'email est requis."));
        return;
      }

      DocumentReference adherentRef = await _firestoreService.collection('adherents').add({
        'firstName': event.firstName,
        'lastName': event.lastName,
        'email': event.email,
        'dateOfBirth': event.dateOfBirth,
        'licence': event.licence,
        'belt': event.belt,
        'discipline': event.discipline,
        'category': event.category,
        'tutor': event.tutor,
        'phone': event.phone,
        'address': event.address,
        'image': event.image,
        'sante': event.sante,
        'medicalCertificate': event.medicalCertificate,
        'invoice': event.invoice,
      });

      bool accountExists = event.userExists;

      if (!accountExists) {
        // Création du compte utilisateur
        User? newUser = await _authService.createUserWithEmailAndPassword(
          event.email,
          'TemporaryPassword123!', // À remplacer par un mot de passe temporaire sécurisé
        );
        if (newUser != null) {
          await _authService.sendInformationEmail(event.email, false);
        }
      } else {
        User? user = _authService.currentUser;
        if (user != null) {
          await _authService.linkUserToAdherent(user);
        } else {
          await _authService.sendInformationEmail(event.email, true);
        }
      }

      emit(SignUpSuccessState(!accountExists, adherentRef.id));
      // Correction ici
    } catch (e) {
      emit(SignUpErrorState("Erreur lors de l'ajout de l'adhérent : ${e.toString()}"));
    }
  }
}
