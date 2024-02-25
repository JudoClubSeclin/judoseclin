import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/dto/user_info_dto.dart';

abstract class UserInfoRepository {
  Future<UserInfoDto> call(String userId);
}

@Injectable(as: UserInfoRepository)
class UserInfoRepositoryImpl implements UserInfoRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @factoryMethod
  UserInfoRepositoryImpl();

  @override
  Future<UserInfoDto> call(String userId) async {
    final user = await firestore.collection('users').doc(userId).get();
    if (user.exists) {
      var data = user.data();
      if (data != null) {
        return UserInfoDto.fromJson(data);
      }
    }
    throw Exception('User not found');
  }
}
