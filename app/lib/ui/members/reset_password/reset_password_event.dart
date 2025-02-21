abstract class ResetPasswordEvent {}

class ResetPasswordRequested extends ResetPasswordEvent {
  final String email;
  ResetPasswordRequested({required this.email});
}
