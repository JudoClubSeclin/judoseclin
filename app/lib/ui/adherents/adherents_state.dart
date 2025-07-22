import 'package:judoseclin/domain/entities/adherents.dart';

abstract class AdherentsState {
  const AdherentsState(); // Ajoutez un constructeur sans nom
}

class SignUpInitialState extends AdherentsState {}

class SignUpLoadingState extends AdherentsState {}

class AllAdherentsLoadedState extends AdherentsState {
  final List<Adherents> adherents;

  AllAdherentsLoadedState(this.adherents);
}

class AdherentsLoadingErrorState extends AdherentsState {
  final String error;

  AdherentsLoadingErrorState(this.error);
}



class SignUpSuccessState extends AdherentsState {
  final String adherentId;
  final bool isNewUser;

  SignUpSuccessState(this.isNewUser, this.adherentId);
}

class FamilyCheckSuccessState extends AdherentsState {
  final String familyId;
  final String email;
  final String phone;

  FamilyCheckSuccessState({
    required this.familyId,
    required this.email,
    required this.phone,
  });
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
