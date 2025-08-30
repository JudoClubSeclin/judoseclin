import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/ui/account/adherents_session.dart';
import 'package:judoseclin/ui/common/widgets/Custom_card/custom_card.dart';
import '../../../core/di/api/auth_service.dart';
import '../../../core/di/api/firestore_service.dart';
import '../../../core/di/injection.dart';

class DonneesUser extends StatefulWidget {
  final Adherents utilisateurPrincipal;

  const DonneesUser({super.key, required this.utilisateurPrincipal});

  @override
  State<DonneesUser> createState() => _DonneesUserState();
}

class _DonneesUserState extends State<DonneesUser> {
  final AuthService _authService = getIt<AuthService>();
  final FirestoreService _firestoreService = getIt<FirestoreService>();

  bool isLoading = true;
  List<Adherents> familyMembers = [];

  @override
  void initState() {
    super.initState();
    fetchFamilyMembers();
  }

  Future<void> fetchFamilyMembers() async {
    try {
      final rawEmail = _authService.currentUser?.email ?? '';
      final userEmail = rawEmail.trim(); // Nettoyage

      if (userEmail.isEmpty) {
        debugPrint("Email utilisateur introuvable");
        setState(() => isLoading = false);
        return;
      }

      // Récupérer le document de l'utilisateur courant
      final userQuery = await _firestoreService
          .collection("adherents")
          .where("email", isEqualTo: userEmail)
          .get();

      if (userQuery.docs.isEmpty) {
        debugPrint("Aucun document trouvé pour cet email : '$userEmail'");
        // On peut fallback sur utilisateurPrincipal si nécessaire
        setState(() {
          familyMembers = [widget.utilisateurPrincipal];
          isLoading = false;
        });
        return;
      }

      final userDoc = userQuery.docs.first;
      final currentUserData = userDoc.data();
      final currentFamilyId = currentUserData['familyId'] ?? '';

      // Récupérer les membres de la famille
      final familyQuery = await _firestoreService
          .collection("adherents")
          .where("familyId", isEqualTo: currentFamilyId)
          .get();

      final members = familyQuery.docs.map((doc) {
        final data = doc.data();
        return Adherents.fromMap(data, doc.id);
      }).toList();

      setState(() {
        familyMembers = members.isNotEmpty ? members : [widget.utilisateurPrincipal];
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Erreur lors de la récupération des membres de la famille : $e");
      setState(() {
        familyMembers = [widget.utilisateurPrincipal];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    if (familyMembers.isEmpty) {
      return const Center(child: Text("Aucune donnée trouvée"));
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10),
      itemCount: familyMembers.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final member = familyMembers[index];
        return
          Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500), // largeur max
                  child:
          CustomCard(
          title: "${member.firstName} ${member.lastName}",
          subTitle: member.email,
          onTap: () {
            final adherentId = member.id;
            if (adherentId.isNotEmpty) {
              getIt<AdherentSession>().setAdherent(adherentId);
              context.goNamed(
                'mes_donnees',
                pathParameters: {'id': adherentId},
              );
            }
          },
          )
              )
        );
      },
    );
  }
}
