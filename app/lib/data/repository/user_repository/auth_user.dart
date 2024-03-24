import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/dto/user_dto.dart';

abstract class AuthUserRepository {
  Stream<UserDto?> get authUser;
}

@Singleton(as: AuthUserRepository)
class AuthUserRepositoryImpl implements AuthUserRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

  AuthUserRepositoryImpl();

  @override
  Stream<UserDto?> get authUser =>
      auth.authStateChanges().map((user) => user != null
          ? UserDto(
              id: user.uid,
              name: user.displayName ?? user.email ?? "",
              email: user.email ?? "",
            )
          : null);
}
