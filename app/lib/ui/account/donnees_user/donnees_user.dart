import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/domain/entities/adherents.dart';

import '../../../core/di/api/auth_service.dart';
import '../../../core/di/api/firestore_service.dart';
import '../../../core/di/injection.dart';

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

      final userQuery = await _firestoreService
          .collection("adherents")
          .where("email", isEqualTo: userEmail)
          .get();

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

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      children: [
        const SizedBox(height: 10),
        ...familyMembers.map((member) {
          return Card(
            color: Colors.transparent,
            elevation: 0.5,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text("${member['firstName']} ${member['lastName']}"),
              subtitle: Text(
                  "${member['category']} - Ceinture: ${member['belt']}"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                String adherentId = member['id'];
                if (adherentId.isNotEmpty) {
                  context.goNamed(
                    'mes_donnees',
                    pathParameters: {'id': adherentId},
                  );
                }
              },
            ),
          );
        })
      ],
    );
  }

}