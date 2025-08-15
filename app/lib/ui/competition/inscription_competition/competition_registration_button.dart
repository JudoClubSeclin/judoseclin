import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:judoseclin/theme.dart';
import '../../../core/di/api/firestore_service.dart';
import 'competition_Registration_bloc.dart';
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
    const beltOrder = ["blanche","blanc-jaune", "jaune", "jaune-orange", "orange","orange-verte", "verte", "verte-bleue", "bleue", "marron", "noire"];
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
        if (currentUser == null) {
          Navigator.of(context).pushNamed('/login');
          return;
        }

        final firestore = GetIt.I<FirestoreService>();

        try {
          // 🔹 Récupération infos adhérent
          final adherentDoc = await firestore.getCollection('adherents').doc(adherentId).get();
          if (!adherentDoc.exists) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Adhérent non trouvé.")),
            );
            return;
          }

          final adherentData = adherentDoc.data() as Map<String, dynamic>?;
          if (adherentData == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Données adhérent introuvables.")),
            );
            return;
          }

          final adherentBelt = adherentData['belt'] as String?;
          final adherentCategory = adherentData['category'] as String?;
          if (adherentBelt == null || adherentCategory == null) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text("Données adhérent incomplètes.",style: textStyleText(context),)),
            );
            return;
          }

          // 🔹 Récupération infos compétition
          final competitionDoc = await firestore.getCollection('competition').doc(competitionId).get();
          if (!competitionDoc.exists) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text("Compétition non trouvée.",style: textStyleText(context))),
            );
            return;
          }

          final competitionData = competitionDoc.data() as Map<String, dynamic>?;
          if (competitionData == null) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text("Données compétition introuvables.",style: textStyleText(context))),
            );
            return;
          }

          // 🔹 Vérification que la catégorie existe
          final categoryValue = competitionData[adherentCategory];
          if (categoryValue == null || categoryValue.toString().isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Votre catégorie (${adherentCategory}) n’est pas autorisée pour cette compétition.",style: textStyleText(context))),
            );
            return;
          }

          // 🔹 Vérification de la ceinture minimale (si définie)
          final minBeltField = "minBelt${adherentCategory[0].toUpperCase()}${adherentCategory.substring(1).toLowerCase()}";
          final minBelt = competitionData[minBeltField] as String?;
          if (minBelt != null && minBelt.isNotEmpty) {
            if (!_isEligible(adherentBelt, minBelt)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(
                    "Votre ceinture (${adherentBelt}) est inférieure à la ceinture minimale (${minBelt}) pour votre catégorie.",style: textStyleText(context)
                )),
              );
              return;
            }
          }

          // ✅ Tout est OK → envoi au Bloc
          final bloc = BlocProvider.of<CompetitionRegistrationBloc>(context);
          bloc.add(RegisterToCompetitionEvent(
            adherentId: adherentId,
            competitionId: competitionId,
            competitionDate: competitionDate,
          ));

          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text("Inscription validée ✅",style: textStyleText(context))),
          );

        } catch (e) {
          debugPrint("Erreur lors de l'inscription : $e");
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text("Erreur lors de l'inscription.",style: textStyleText(context))),
          );
        }
      },
    );
  }
}
