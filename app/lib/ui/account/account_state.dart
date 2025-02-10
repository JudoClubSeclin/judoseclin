abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final Map<String, dynamic> userData;

  AccountLoaded({required this.userData});
}

class AccountError extends AccountState {
  final String message;

  AccountError({required this.message});
}
