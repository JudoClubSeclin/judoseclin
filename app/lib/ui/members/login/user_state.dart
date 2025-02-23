// user_state.dart

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {}

class LoginFailure extends UserState {
  final String error;

  LoginFailure({required this.error});
}

class PasswordResetInProgress extends UserState {}

class PasswordResetSuccess extends UserState {}

class PasswordResetFailure extends UserState {
  final String error;

  PasswordResetFailure({required this.error});
}

class AuthenticationErrorState extends UserState {}

class UserDataLoadedState extends UserState {
  final Map<String, dynamic> userData;
  UserDataLoadedState(this.userData);
}
