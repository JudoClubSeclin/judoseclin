import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/repository/user_repository/user_data_repository.dart';

@singleton
class AccountInteractor {
  final UserDataRepository _dataRepository;

  AccountInteractor(this._dataRepository);

  Future<Map<String, dynamic>> invoke(String userId) async {
    return await _dataRepository.fetchUserData(userId);
  }

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    return await _dataRepository.fetchUserData(userId);
  }
}
