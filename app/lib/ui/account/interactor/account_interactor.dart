import 'package:judoseclin/data/repository/user_repository/user_data_repository.dart';

class AccountInteractor {
  final UserDataRepository _dataRepository;
  final String userId;
  AccountInteractor(this._dataRepository, this.userId);

  Future<Map<String, dynamic>> invoke(String userId) async {
    return await _dataRepository.fetchUserData(userId);
  }

  Future<Map<String, dynamic>> fetchUserData(userId) async {
    return await _dataRepository.fetchUserData(userId);
  }
}
