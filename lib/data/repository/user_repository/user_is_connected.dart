import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class UserIsConnectedRepository {
  Stream<bool> get isConnected;
}

@Singleton(as: UserIsConnectedRepository)
class UserIsConnectedRepositoryImpl implements UserIsConnectedRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

  UserIsConnectedRepositoryImpl();

  @override
  Stream<bool> get isConnected =>
      auth.authStateChanges().map((user) => user != null);
}
