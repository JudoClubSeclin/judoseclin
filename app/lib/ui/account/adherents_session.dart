import 'package:injectable/injectable.dart';

@singleton
class AdherentSession {
  String? _adherentId;

  void setAdherent(String id) {
    _adherentId = id;
  }

  String? getAdherent() => _adherentId;
}
