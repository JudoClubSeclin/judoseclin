 class AccountState {
  final String? adherentId;
  final bool isLoading;
  final String? errorMessage;

  AccountState({
    this.adherentId,
    this.isLoading = false,
    this.errorMessage,
  });

  AccountState copyWith({
    String? adherentId,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AccountState(
      adherentId: adherentId ?? this.adherentId,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

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
