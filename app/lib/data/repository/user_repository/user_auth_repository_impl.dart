import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/repository/user_repository/user_auth_repository.dart';

@Singleton(as: UserAuthRepository)
class UserAuthRepositoryImpl implements UserAuthRepository {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Future<User?> login(String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> register(
    String email,
    String password,
    Map<String, dynamic> userInfo,
  ) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Ajoutez des données utilisateur supplémentaires ici
      if (result.user != null) {
        final uid = result.user!.uid;
        await firestore.collection('Users').doc(uid).set(userInfo);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }
}
