abstract class AccountEvent {}

class LoadUserInfo extends AccountEvent {
  final String? adherentId;
  LoadUserInfo({this.adherentId});
}
