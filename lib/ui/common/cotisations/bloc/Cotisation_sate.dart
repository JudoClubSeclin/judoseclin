abstract class CotisationState {
  const CotisationState(); // Ajoutez un constructeur sans nom
}

class SignUpInitialState extends CotisationState {}

class SignUpLoadingState extends CotisationState {}

class SignUpSuccessState extends CotisationState {}

class SignUpErrorState extends CotisationState {
  final String error;

  SignUpErrorState(this.error);
}
