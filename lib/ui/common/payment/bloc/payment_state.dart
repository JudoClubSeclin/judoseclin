abstract class PaymentState {
  const PaymentState(); // Ajoutez un constructeur sans nom
}

class SignUpInitialState extends PaymentState {}

class SignUpLoadingState extends PaymentState {}

class SignUpSuccessState extends PaymentState {}

class SignUpErrorState extends PaymentState {
  final String error;

  SignUpErrorState(this.error);
}
