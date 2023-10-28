import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FetchUserDataUseCase {
  Future<Map<String, dynamic>> invoke() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final firestore = FirebaseFirestore.instance;
    if (currentUser != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('Users').doc(currentUser.uid).get();
      return snapshot.data() as Map<String, dynamic>;
    }
    throw Exception('No current user found.');
  }
}
