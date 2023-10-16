import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountInteractor {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AccountInteractor({required this.auth, required this.firestore});

  Future<Map<String, dynamic>> fetchUserData() async {
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot snapshot =
          await firestore.collection('Users').doc(currentUser.uid).get();
      return snapshot.data() as Map<String, dynamic>;
    }
    throw Exception('No current user found.');
  }
}
