abstract class AdherentsState {
  const AdherentsState(); // Ajoutez un constructeur sans nom
}

class SignUpInitialState extends AdherentsState {}

class SignUpLoadingState extends AdherentsState {}

class SignUpSuccessState extends AdherentsState {
  final String adherentId;
  final bool isNewUser;

  SignUpSuccessState(this.isNewUser, this.adherentId);
}

class SignUpErrorState extends AdherentsState {
  final String error;

  SignUpErrorState(this.error);
}

class PdfGenerationState extends AdherentsState {
  final bool isGenerating;
  final String? error;

  PdfGenerationState({required this.isGenerating, this.error});
}
