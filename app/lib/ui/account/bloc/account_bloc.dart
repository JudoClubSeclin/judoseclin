import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../interactor/account_interactor.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountInteractor accountInteractor;
  final String userId;

  AccountBloc(  {required this.accountInteractor, required this.userId}) : super(AccountInitial()) {
    on<LoadUserInfo>((event, emit) async {
      emit(AccountLoading());
      try {
        final userData = await accountInteractor.fetchUserData(userId);
        debugPrint('AccountBloc: LoadUserInfo event received');

        emit(AccountLoaded(userData: userData));
      } catch (e) {
        debugPrint('AccountBloc: Error - ${e.toString()}');

        emit(AccountError(message: e.toString()));
      }
    });
  }
}
