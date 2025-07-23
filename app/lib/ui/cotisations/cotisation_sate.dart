import '../../domain/entities/cotisation.dart';

abstract class CotisationState {}

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

class CotisationsLoadedState extends CotisationState {
  final Iterable<Cotisation> cotisations;

  CotisationsLoadedState(this.cotisations);
}


