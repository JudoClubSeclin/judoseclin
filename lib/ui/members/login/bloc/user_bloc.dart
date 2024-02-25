// user_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:judoseclin/ui/members/interactor/users_interactor.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersInteractor usersInteractor;
  final String userId;

  UserBloc(this.usersInteractor, {required this.userId})
      : super(UserInitial()) {
    on<FetchUserDataEvent>((event, emit) async {
      try {
        Map<String, dynamic> userData =
            await usersInteractor.fetchUserData(userId);
        emit(UserDataLoadedState(userData));
      } catch (e) {
        emit(AuthenticationErrorState());
      }
    });

    on<LoginWithEmailPassword>((event, emit) async {
      emit(UserLoading());
      try {
        await usersInteractor.login(event.email, event.password);
        Map<String, dynamic> userData =
            await usersInteractor.fetchUserData(userId);
        emit(UserDataLoadedState(userData));
        event.navigateToAccount();
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });

    on<LogOutEvent>((event, emit) async {
      try {
        await usersInteractor.logOut();
        emit(UserInitial());
      } catch (error) {
        emit(AuthenticationErrorState());
      }
    });
  }
}
