import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_interactor.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountInteractor accountInteractor;
  final String userId;

  AccountBloc({required this.accountInteractor, required this.userId})
      : super(AccountInitial()) {
    on<LoadUserInfo>((event, emit) async {
      emit(AccountLoading());
      try {
        Map<String, dynamic> userData;
        if (event.adherentId != null && event.adherentId!.isNotEmpty) {
          debugPrint('AccountBloc: LoadUserInfo event with adherentId ${event.adherentId}');
          userData = await accountInteractor.fetchUserData(event.adherentId!);
        } else {
          debugPrint('AccountBloc: LoadUserInfo event with connected userId $userId');
          userData = await accountInteractor.fetchUserData(userId);
        }
        emit(AccountLoaded(userData: userData));
      } catch (e) {
        debugPrint('AccountBloc: Error - ${e.toString()}');
        emit(AccountError(message: e.toString()));
      }
    });
  }
}

