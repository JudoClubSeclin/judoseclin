abstract class AddCompetitionState {
  const AddCompetitionState();
}

class AddCompetitionSignUpInitialState extends AddCompetitionState {}

class AddCompetitionSignUpLoadingState extends AddCompetitionState {}

class AddCompetitionSignUpSuccessState extends AddCompetitionState {
  final String addCompetitionId;
  AddCompetitionSignUpSuccessState({required this.addCompetitionId});
}

class AddCompetitionSignUpErrorState extends AddCompetitionState {
  final String error;
  AddCompetitionSignUpErrorState(this.error);
}
