import 'dart:async';

import 'package:bloc/bloc.dart';

import '../interactor/account_interactor.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountInteractor accountInteractor;

  AccountBloc({required this.accountInteractor}) : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is LoadUserInfo) {
      yield AccountLoading();
      try {
        final userData = await accountInteractor.fetchUserData();
        yield AccountLoaded(userData: userData);
      } catch (e) {
        yield AccountError(message: e.toString());
      }
    }
  }
}
