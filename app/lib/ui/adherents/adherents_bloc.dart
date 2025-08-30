import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/core/di/api/auth_service.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:judoseclin/ui/cotisations/cotisation_interactor.dart';

import '../../core/utils/generete_and_download_pdf.dart';
import 'adherents_state.dart';
import 'adherents_event.dart';
import 'adherents_interactor.dart';
import 'package:flutter/material.dart';

class AdherentsBloc extends Bloc<AdherentsEvent, AdherentsState> {
  final AdherentsInteractor adherentsInteractor;
  final CotisationInteractor cotisationInteractor;
  final String adherentId;
  final AuthService _authService;
  final FirestoreService _firestoreService;

  AdherentsBloc(
      this.adherentsInteractor,
      this.cotisationInteractor,
      this._authService,
      this._firestoreService, {
        required this.adherentId,
      }) : super(SignUpInitialState()) {
    debugPrint('>>> AdherentsBloc constructor called');

    on<AddAdherentsSignUpEvent>(_onAddAdherentsSignUp);
    on<GeneratePdfEvent>(_onGeneratePdf);
    on<CheckFamilyByAddressEvent>(_onCheckFamilyByAddress);
    on<LoadAllAdherentsEvent>((event, emit) async {
      emit(SignUpLoadingState());
      try {
        final adherents = await adherentsInteractor.fetchAdherentsData();
        emit(AllAdherentsLoadedState(adherents));
      } catch (e) {
        emit(AdherentsLoadingErrorState(e.toString()));
      }
    });
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

      // Ajout de l'adhérent dans Firestore
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
        'familyId': event.familyId,
        'additionalAddress': event.additionalAddress,
        'postalCode': event.postalCode,
        'boardPosition': event.boardPosition,


      });

      bool accountExists = event.userExists;

      // Fonction interne pour envoyer l'email
      Future<bool> _envoyerEmailInvitationBloc({
        required String email,
        required String lastName,
        required String firstName,
      }) async {
        try {
          final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
            'sendEmail', // Nom de ta fonction callable Firebase
            options: HttpsCallableOptions(
              timeout: const Duration(seconds: 30),
            ),
          );

          final messageText = 'Bonjour $firstName $lastName,\n\n'
              'Votre fiche adhérent a été créée. '
              'Veuillez créer votre compte en cliquant sur le lien ci-dessous.\n\n'
              'Cordialement,\nL\'équipe du judo club Seclin.';

          final response = await callable.call(<String, dynamic>{
            'to': email,
            'subject': 'Créer votre compte',
            'text': messageText,
            'lien': 'https://judoseclin.fr/#/inscription?email=${Uri.encodeComponent(email)}',
          });

          return response.data['success'] == true;
        } catch (e) {
          debugPrint('Erreur envoi email depuis Bloc: $e');
          return false;
        }
      }

      // Envoi de l'email uniquement si le compte n'existe pas
      if (!accountExists) {
        await _envoyerEmailInvitationBloc(
          email: event.email,
          lastName: event.lastName,
          firstName: event.firstName,
        );
      }

      emit(SignUpSuccessState(!accountExists, adherentRef.id));

      // Génération du PDF
      add(GeneratePdfEvent(adherentId: adherentRef.id));
    } catch (e) {
      emit(SignUpErrorState("Erreur lors de l'ajout de l'adhérent : ${e.toString()}"));
    }
  }

  Future<void> _onGeneratePdf(
      GeneratePdfEvent event,
      Emitter<AdherentsState> emit,
      ) async {
    emit(PdfGenerationState(isGenerating: true));
    try {
      await generateAndPrintPdf(event.adherentId, adherentsInteractor, cotisationInteractor);
      emit(PdfGenerationState(isGenerating: false));
    } catch (e) {
      emit(PdfGenerationState(isGenerating: false, error: e.toString()));
    }
  }

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
      }
    } catch (e) {
      emit(SignUpErrorState("Erreur lors de la vérification de l'adresse : ${e.toString()}"));
    }
  }
}
