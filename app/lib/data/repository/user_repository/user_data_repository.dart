
abstract class UserDataRepository {
  Future<Map<String, dynamic>> fetchUserData(String userId);
  Future<void> updateUserData(String userId, Map<String, dynamic> newData);
}
