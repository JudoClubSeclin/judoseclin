import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/core/di/api/auth_service.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';

import 'account_interactor.dart';
import 'account_event.dart';
import 'account_state.dart';

@singleton
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountInteractor accountInteractor;
  final AuthService auth;
  final FirestoreService firestore;

  AccountBloc({required this.accountInteractor, required this.auth, required this.firestore})
      : super(AccountInitial()) {
    on<LoadUserInfo>(_onLoadUserInfo);
  }

  Future<void> _onLoadUserInfo(LoadUserInfo event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      final currentUserId = auth.currentUser?.uid; // Récupération dynamique
      if (currentUserId == null) throw Exception("Utilisateur non connecté");

      Map<String, dynamic> userData;
      if (event.adherentId != null && event.adherentId!.isNotEmpty) {
        userData = await accountInteractor.fetchUserData(event.adherentId!);
      } else {
        userData = await accountInteractor.fetchUserData(currentUserId); // Utilisation de l'UID dynamique
      }
      emit(AccountLoaded(userData: userData));
    } catch (e) {
      emit(AccountError(message: e.toString()));
    }
  }

  Future<void> updateUserData(Map<String, dynamic> updatedData) async {}
}

