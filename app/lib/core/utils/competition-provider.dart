import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserCompetitionsProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getUserInscriptions() async {
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (userId.isEmpty) return [];

    try {
      // On récupère les compétitions auxquelles l'utilisateur est inscrit
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data() as Map<String, dynamic>;
        return List<String>.from(data['competition'] ?? []);
      }
      return [];
    } catch (e) {
      print('Erreur lors de la récupération des inscriptions : $e');
      return [];
    }
  }
}
