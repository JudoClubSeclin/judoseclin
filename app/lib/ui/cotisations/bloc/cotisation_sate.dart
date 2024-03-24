abstract class CotisationState {
  const CotisationState(); // Ajoutez un constructeur sans nom
}

class CotisationSignUpInitialState extends CotisationState {}

class CotisationSignUpLoadingState extends CotisationState {}

class CotisationSignUpSuccessState extends CotisationState {
  final String adherentId;
  CotisationSignUpSuccessState({required this.adherentId});
}

class CotisationSignUpErrorState extends CotisationState {
  final String error;

  CotisationSignUpErrorState(this.error);
}
