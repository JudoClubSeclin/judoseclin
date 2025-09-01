import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/theme.dart';
import '../../../core/di/api/firestore_service.dart';
import 'competition_registration_bloc.dart';
import 'competition_registration_event.dart';
import '../../common/widgets/buttons/custom_buttom.dart';

class InscriptionButton extends StatelessWidget {
  final String competitionId;
  final String adherentId;
  final DateTime competitionDate;

  const InscriptionButton({
    super.key,
    required this.competitionId,
    required this.adherentId,
    required this.competitionDate,
  });

  /// Vérifie que l’adhérent a la ceinture minimale
  bool _isEligible(String adherentBelt, String minBelt) {
    const beltOrder = [
      "blanche","blanc-jaune", "jaune", "jaune-orange", "orange",
      "orange-verte", "verte", "verte-bleue", "bleue", "marron", "noire"
    ];
    final adherentIndex = beltOrder.indexOf(adherentBelt.toLowerCase());
    final minIndex = beltOrder.indexOf(minBelt.toLowerCase());

    if (adherentIndex == -1 || minIndex == -1) return false;
    return adherentIndex >= minIndex;
  }

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      label: "Je m'inscris",
        onPressed: () async {
          final currentUser = FirebaseAuth.instance.currentUser;
          final scaffold = ScaffoldMessenger.of(context); // capture
          final router = GoRouter.of(context);            // capture

          if (currentUser == null) {
            router.go("/login");
            return;
          }

          final firestore = GetIt.I<FirestoreService>();

          try {
            final adherentDoc = await firestore.getCollection('adherents').doc(adherentId).get();

            if (!adherentDoc.exists) {
              scaffold.showSnackBar(
                SnackBar(content: Text("Adhérent non trouvé.", style: textStyleText(context))),
              );
              return;
            }

            final existingRegistrationsQuery = await firestore.getCollection('competition_registration')
                .where('adherentId', isEqualTo: adherentId)
                .where('competitionId', isEqualTo: competitionId)
                .get();

            if (existingRegistrationsQuery.docs.isNotEmpty) {
              scaffold.showSnackBar(
                SnackBar(content: Text("⚠️ Vous êtes déjà inscrit à cette compétition.", style: textStyleText(context))),
              );
              return;
            }

            // Récupération infos adhérent
            final adherentData = adherentDoc.data() as Map<String, dynamic>;
            final adherentBelt = adherentData['belt'] as String?;
            final adherentCategory = adherentData['category'] as String?;

            if (adherentBelt == null || adherentCategory == null) {
              scaffold.showSnackBar(
                SnackBar(content: Text("Données adhérent incomplètes.", style: textStyleText(context))),
              );
              return;
            }

            final competitionDoc = await firestore.getCollection('competition').doc(competitionId).get();
            final competitionData = competitionDoc.data() as Map<String, dynamic>;
            final minBeltField = "minBelt${adherentCategory[0].toUpperCase()}${adherentCategory.substring(1).toLowerCase()}";
            final minBelt = competitionData[minBeltField] as String?;

            if (minBelt != null && minBelt.isNotEmpty && !_isEligible(adherentBelt, minBelt)) {
              scaffold.showSnackBar(
                SnackBar(content: Text("Votre ceinture ($adherentBelt) est inférieure à la ceinture minimale (${minBelt})", style: textStyleText(context))),
              );
              return;
            }

            final bloc = BlocProvider.of<CompetitionRegistrationBloc>(context);
            bloc.add(RegisterToCompetitionEvent(
              adherentId: adherentId,
              competitionId: competitionId,
              competitionDate: competitionDate,
            ));

            scaffold.showSnackBar(
              SnackBar(content: Text("Inscription validée ✅", style: textStyleText(context))),
            );

          } catch (e) {
            debugPrint("Erreur lors de l'inscription : $e");
            scaffold.showSnackBar(
              SnackBar(content: Text("Erreur lors de l'inscription.", style: textStyleText(context))),
            );
          }
        }



    );
  }
}
