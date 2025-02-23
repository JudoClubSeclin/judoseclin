import 'package:firebase_core/firebase_core.dart';
import 'package:injectable/injectable.dart';

@injectable
class FirebaseClient {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }
}
