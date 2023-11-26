abstract class InscriptionState {}

class SignUpInitialState extends InscriptionState {}

class SignUpLoadingState extends InscriptionState {}

class SignUpSuccessState extends InscriptionState {}

class SignUpErrorState extends InscriptionState {
  final String error;

  SignUpErrorState(this.error);
}

class SignUpFailureState extends InscriptionState {}
