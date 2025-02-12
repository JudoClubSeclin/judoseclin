import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/theme.dart';

class DonneesUser extends StatefulWidget {
  const DonneesUser({super.key});

  @override
  State<DonneesUser> createState() => _DonneesUserState();
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
    debugPrint("🔍 Fonction fetchUserData exécutée");

    try {
      String? userEmail = FirebaseAuth.instance.currentUser?.email;
      if (userEmail == null || userEmail.isEmpty) {
        debugPrint("❌ Aucun email trouvé !");
        return;
      }

      debugPrint("🔍 Email utilisateur trouvé : $userEmail");

      var querySnapshot = await FirebaseFirestore.instance
          .collection("adherents")
          .where("email", isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isEmpty) {
        debugPrint("❌ Aucun adhérent trouvé pour cet email.");
        return;
      }

      setState(() {
        userData = querySnapshot.docs.first.data();
        isLoading = false; // Fin du chargement
      });

      debugPrint("✅ Données récupérées : $userData");
    } catch (e) {
      debugPrint("❌ Erreur lors de la récupération des données : $e");
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

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(children: [
              Text(
                "Prénom: ${userData!['lastName'] ?? 'Non disponible'}, ",
                style: textStyleText(context),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Nom: ${userData!['firstName'] ?? 'Non disponible'}, ",
                style: textStyleText(context),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Email: ${userData!['email'] ?? 'Non disponible'}, ",
                style: textStyleText(context),
              ),
            ]),
            const SizedBox(
              width: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              children: [
                Text(
                  "Adresse: ${userData!['address'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Téléphone: ${userData!['phone'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Categories: ${userData!['category'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Discipline: ${userData!['discipline'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Ceinture: ${userData!['belt'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  " N° de licence: ${userData!['licence'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
