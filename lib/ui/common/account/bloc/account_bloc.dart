import 'package:bloc/bloc.dart';

import '../interactor/account_interactor.dart';
import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountInteractor accountInteractor;

  AccountBloc({required this.accountInteractor}) : super(AccountInitial()) {
    on<LoadUserInfo>((event, emit) async {
      emit(AccountLoading());
      try {
        final userData = await accountInteractor.fetchUserData();
        emit(AccountLoaded(userData: userData));
      } catch (e) {
        emit(AccountError(message: e.toString()));
      }
    });
  }
}
