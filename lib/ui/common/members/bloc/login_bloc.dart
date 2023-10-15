import 'package:flutter_bloc/flutter_bloc.dart';

import '../interactor/login_interactor.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginInteractor loginInteractor;

  LoginBloc({required this.loginInteractor}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithEmailPassword) {
      yield LoginLoading();
      try {
        await loginInteractor.login(event.email, event.password);
        yield LoginSuccess();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
