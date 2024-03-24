abstract class InscriptionState {}

class SignUpInitialState extends InscriptionState {}

class SignUpLoadingState extends InscriptionState {}

class SignUpSuccessState extends InscriptionState {
  final String userId;
  SignUpSuccessState({required this.userId});
}

class SignUpErrorState extends InscriptionState {
  final String error;

  SignUpErrorState(this.error);
}

class SignUpFailureState extends InscriptionState {}
