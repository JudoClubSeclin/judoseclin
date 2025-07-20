import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/core/di/api/auth_service.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';

import '../../core/utils/envoyer_email_invitation.dart';
import '../../core/utils/generete_and_download_pdf.dart';
import 'adherents_state.dart';
import 'interactor/adherents_interactor.dart';
import 'adherents_event.dart';

class AdherentsBloc extends Bloc<AdherentsEvent, AdherentsState> {
  final AdherentsInteractor adherentsInteractor;
  final String adherentId;
  final AuthService _authService;
  final FirestoreService _firestoreService;

<<<<<<< HEAD
  AdherentsBloc(
    this.adherentsInteractor,
    this._authService,
    this._firestoreService, {
    required this.adherentId,
  }) : super(SignUpInitialState()) {
=======
  AdherentsBloc(this.adherentsInteractor, this._authService,
      this._firestoreService, {required this.adherentId})
      : super(SignUpInitialState()) {
>>>>>>> refactoclean
    on<AddAdherentsSignUpEvent>(_onAddAdherentsSignUp);
    on<GeneratePdfEvent>(_onGeneratePdf);
    on<CheckFamilyByAddressEvent>(_onCheckFamilyByAddress);

  }

<<<<<<< HEAD
  Future<void> _onAddAdherentsSignUp(
    AddAdherentsSignUpEvent event,
    Emitter<AdherentsState> emit,
  ) async {
=======
  Future<void> _onAddAdherentsSignUp(AddAdherentsSignUpEvent event,
      Emitter<AdherentsState> emit,) async {
>>>>>>> refactoclean
    emit(SignUpLoadingState());
    try {
      if (event.email.isEmpty) {
        emit(SignUpErrorState("L'email est requis."));
        return;
      }

<<<<<<< HEAD
      DocumentReference adherentRef = await _firestoreService
          .collection('adherents')
          .add({
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
=======
      DocumentReference adherentRef = await _firestoreService.collection(
          'adherents').add({
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
        'familyId': event.familyId
      });
>>>>>>> refactoclean

      bool accountExists = event.userExists;

      if (!accountExists) {
        await envoyerEmailInvitation(
<<<<<<< HEAD
          email: event.email,
          nom: event.firstName,
          prenom: event.lastName,
        );
=======
            email: event.email, nom: event.firstName, prenom: event.lastName);
>>>>>>> refactoclean
      } else {
        User? user = _authService.currentUser;
        if (user != null) {
          await _authService.linkUserToAdherent(user);
        } else {
          await _authService.sendInformationEmail(event.email, true);
        }
      }

      emit(SignUpSuccessState(!accountExists, adherentRef.id));

      // Déclencher la génération du PDF après l'enregistrement réussi
      add(GeneratePdfEvent(adherentId: adherentRef.id));
    } catch (e) {
<<<<<<< HEAD
      emit(
        SignUpErrorState(
          "Erreur lors de l'ajout de l'adhérent : ${e.toString()}",
        ),
      );
    }
  }

  Future<void> _onGeneratePdf(
    GeneratePdfEvent event,
    Emitter<AdherentsState> emit,
  ) async {
=======
      emit(SignUpErrorState(
          "Erreur lors de l'ajout de l'adhérent : ${e.toString()}"));
    }
  }

  Future<void> _onGeneratePdf(GeneratePdfEvent event,
      Emitter<AdherentsState> emit,) async {
>>>>>>> refactoclean
    emit(PdfGenerationState(isGenerating: true));
    try {
      await generateAndPrintPdf(event.adherentId, adherentsInteractor);
      emit(PdfGenerationState(isGenerating: false));
    } catch (e) {
      emit(PdfGenerationState(isGenerating: false, error: e.toString()));
    }
  }
<<<<<<< HEAD
}
=======
  Future<void> _onCheckFamilyByAddress(
      CheckFamilyByAddressEvent event,
      Emitter<AdherentsState> emit,
      ) async {
    try {
      final query = await _firestoreService
          .collection('adherents')
          .where('address', isEqualTo: event.address)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        final doc = query.docs.first;
        final data = doc.data();

        final familyId = data['familyId'] ?? doc.id;
        final email = data['email'] ?? '';
        final phone = data['phone'] ?? '';

        emit(FamilyCheckSuccessState(
          familyId: familyId,
          email: email,
          phone: phone,
        ));
      } else {
        // Aucun membre de famille trouvé, ne rien faire ou retourner un état neutre
      }
    } catch (e) {
      // Optionnel : ajouter un état d’erreur si nécessaire
      emit(SignUpErrorState("Erreur lors de la vérification de l'adresse : ${e.toString()}"));
    }
  }
}
>>>>>>> refactoclean
