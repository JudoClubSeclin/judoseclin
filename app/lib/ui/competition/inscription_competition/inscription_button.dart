import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/theme.dart';

import '../../../core/di/api/firestore_service.dart';
import '../../../core/di/injection.dart';
import '../../../core/utils/is_category_allowed.dart';
import '../../common/widgets/buttons/custom_buttom.dart';
import 'inscription_competition_bloc.dart';
import 'inscription_competition_event.dart';
import 'inscription_competition_state.dart';

class InscriptionButton extends StatelessWidget {
  final String competitionId;
  final Map<String, dynamic> competitionData;
  final String? adherentCategorie;

  const InscriptionButton({
    super.key,
    required this.competitionId,
    required this.competitionData,
    required this.adherentCategorie,
  });

  bool estEligibilePourCompetition(String? adherentCategorie) {
    if (competitionData.isEmpty ||
        adherentCategorie == null ||
        adherentCategorie.isEmpty) {
      return false;
    }

    String categorieNormalisee = adherentCategorie.toLowerCase();

    return (categorieNormalisee == 'poussin' &&
            competitionData['poussin']?.isNotEmpty == true) ||
        (categorieNormalisee == 'benjamin' &&
            competitionData['benjamin']?.isNotEmpty == true) ||
        (categorieNormalisee == 'minime' &&
            competitionData['minime']?.isNotEmpty == true) ||
        (categorieNormalisee == 'cadet' &&
            competitionData['cadet']?.isNotEmpty == true) ||
        ((categorieNormalisee == 'junior' || categorieNormalisee == 'senior') &&
            competitionData['juniorSenior']?.isNotEmpty == true);
  }

  void _showDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title, style: textStyleText(context)),
          content: Text(content, style: textStyleText(context)),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('OK', style: textStyleText(context)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InscriptionCompetitionBloc>(
      create: (context) => getIt<InscriptionCompetitionBloc>(),
      child: Builder(
        builder:
            (context) => BlocListener<
              InscriptionCompetitionBloc,
              InscriptionCompetitionState
            >(
              listener: (context, state) {
                if (state is InscriptionCompetitionSuccess) {
                  _showDialog(
                    context,
                    'Inscription réussie',
                    'Votre inscription a été validée avec succès !',
                  );
                } else if (state is InscriptionCompetitionError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Échec de l\'inscription: ${state.errorMessage}',
                      ),
                    ),
                  );
                }
              },
              child: CustomButton(
                label: 'JE M\'INSCRIS',
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user == null) {
                    context.go('/login');
                    return;
                  }

                  final firestore = GetIt.I<FirestoreService>();

                  try {
                    bool allowed = await isCategoryAllowed(
                      user.email!,
                      competitionId,
                      firestore,
                    );

                    if (allowed) {
                      context.read<InscriptionCompetitionBloc>().add(
                        RegisterForCompetition(
                          competitionId: competitionId,
                          userId: user.uid,
                        ),
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Inscription validée ✅",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                              ),
                            ),
                            content: Text(
                              "Félicitations ! Vous êtes inscrit à la compétition.",
                              style: textStyleText(context),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "Inscription refusée ❌",
                              style: TextStyle(color: Colors.red, fontSize: 18),
                            ),
                            content: Text(
                              "Votre catégorie n'est pas prévue pour cette compétition.",
                              style: textStyleText(context),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            "Erreur 🚨",
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text(
                            "Une erreur s'est produite : ${e.toString()}",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
      ),
    );
  }
}
