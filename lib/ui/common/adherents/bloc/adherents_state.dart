abstract class AdherentsState {
  const AdherentsState(); // Ajoutez un constructeur sans nom
}

class SignUpInitialState extends AdherentsState {}

class SignUpLoadingState extends AdherentsState {}

class SignUpSuccessState extends AdherentsState {
  final String adherentId;
  SignUpSuccessState({required this.adherentId});
}

class SignUpErrorState extends AdherentsState {
  final String error;

  SignUpErrorState(this.error);
}
