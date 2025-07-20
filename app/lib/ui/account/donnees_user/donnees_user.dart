import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/adherents.dart';

import '../../../core/di/api/auth_service.dart';
import '../../../core/di/api/firestore_service.dart';
import '../../../core/di/injection.dart';
import '../view/compte_adherent_view.dart';

class DonneesUser extends StatefulWidget {
  final List<Adherents> adherents;
  final Adherents utilisateurPrincipal;

  const DonneesUser({
    required this.adherents,
    required this.utilisateurPrincipal,
    super.key,
  });

  @override
  State<DonneesUser> createState() => _DonneesUserState();
}

class _DonneesUserState extends State<DonneesUser> {
  final AuthService _authService = getIt<AuthService>();
  final FirestoreService _firestoreService = getIt<FirestoreService>();

  Map<String, dynamic>? userData;
  bool isLoading = true;
  List<Map<String, dynamic>> familyMembers = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final userEmail = _authService.currentUser?.email;
      if (userEmail == null || userEmail.isEmpty) {
        debugPrint("Email utilisateur introuvable");
        return;
      }

<<<<<<< HEAD
      debugPrint("🔍 Email utilisateur trouvé : $userEmail");

      var querySnapshot =
          await FirebaseFirestore.instance
              .collection("adherents")
              .where("email", isEqualTo: userEmail)
              .get();
=======
      final userQuery = await _firestoreService
          .collection("adherents")
          .where("email", isEqualTo: userEmail)
          .get();
>>>>>>> refactoclean

      if (userQuery.docs.isEmpty) {
        debugPrint("Aucun document trouvé pour cet email : $userEmail");
        return;
      }

      final userDoc = userQuery.docs.first;
      final currentUserData = userDoc.data();
      final currentFamilyId = currentUserData['familyId'];

      if (currentFamilyId == null) {
        debugPrint("Aucun familyId trouvé pour cet utilisateur");
        return;
      }

      debugPrint("FAMILY ID: $currentFamilyId");

      final familyQuery = await _firestoreService
          .collection("adherents")
          .where("familyId", isEqualTo: currentFamilyId)
          .get();

      final members = familyQuery.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      setState(() {
        userData = currentUserData;
        familyMembers = members;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Erreur lors de la récupération des données utilisateur : $e");
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

    if (familyMembers.isEmpty) {
      return const Center(child: Text("Aucune donnée trouvée"));
    }

<<<<<<< HEAD
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              children: [
                Text(
                  "Prénom: ${userData!['lastName'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(width: 10),
                Text(
                  "Nom: ${userData!['firstName'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(width: 10),
                Text(
                  "Email: ${userData!['email'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const SizedBox(height: 20),
            Wrap(
              children: [
                Text(
                  "Adresse: ${userData!['address'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(width: 10),
                Text(
                  "Téléphone: ${userData!['phone'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 20),
            Wrap(
              children: [
                const SizedBox(width: 10),
                Text(
                  "Categories: ${userData!['category'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(width: 10),
                Text(
                  "Discipline: ${userData!['discipline'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(width: 10),
                Text(
                  "Ceinture: ${userData!['belt'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
                const SizedBox(width: 10),
                Text(
                  " N° de licence: ${userData!['licence'] ?? 'Non disponible'}, ",
                  style: textStyleText(context),
                ),
              ],
            ),
          ],
        ),
      ),
=======
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: familyMembers.length,
      itemBuilder: (context, index) {
        final member = familyMembers[index]; // Récupérer le membre correspondant à l'index
        return Card(
          color: Colors.transparent,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            title: Text("${member['firstName']} ${member['lastName']}"),
            subtitle: Text(
                "${member['category']} - Ceinture: ${member['belt']}"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              debugPrint("ID du membre cliqué: ${member['id']}"); // Vérifiez dans la console

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CompteAdherentView(adherentId: member['id']),
                ),
              );
            },
          ),
        );
      },
>>>>>>> refactoclean
    );

  }
}
