import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonneesUser extends StatefulWidget {
  @override
  _DonneesUserState createState() => _DonneesUserState();
}

class _DonneesUserState extends State<DonneesUser> {
  Map<String, dynamic>? userData;
  bool isLoading = true; // Indicateur de chargement

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Appel de la fonction au démarrage du widget
  }

  Future<void> fetchUserData() async {
    print("🔍 Fonction fetchUserData exécutée");

    try {
      String? userEmail = FirebaseAuth.instance.currentUser?.email;
      if (userEmail == null || userEmail.isEmpty) {
        print("❌ Aucun email trouvé !");
        return;
      }

      print("🔍 Email utilisateur trouvé : $userEmail");

      var querySnapshot = await FirebaseFirestore.instance
          .collection("adherents")
          .where("email", isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print("❌ Aucun adhérent trouvé pour cet email.");
        return;
      }

      setState(() {
        userData = querySnapshot.docs.first.data();
        isLoading = false; // Fin du chargement
      });

      print("✅ Données récupérées : $userData");
    } catch (e) {
      print("❌ Erreur lors de la récupération des données : $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (userData == null) {
      return const Center(child: Text("Aucune donnée trouvée"));
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nom: ${userData!['lastName'] ?? 'Non disponible'}"),
          Text("Prénom: ${userData!['firstName'] ?? 'Non disponible'}"),
          Text("Email: ${userData!['email'] ?? 'Non disponible'}"),
          Text("Téléphone: ${userData!['phone'] ?? 'Non disponible'}"),
        ],
      ),
    );
  }
}
