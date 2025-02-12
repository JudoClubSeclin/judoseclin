import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/theme.dart';

import '../../common/widgets/buttons/custom_buttom.dart';
import 'inscription_competition_bloc.dart';
import 'inscription_competition_event.dart';
import 'inscription_competition_state.dart';

class InscriptionButton extends StatelessWidget {
  final String competitionId;
  final Map<String, dynamic> competitionData; // Données de la compétition
  final String adherentCategorie; // Catégorie de l'adhérent

  const InscriptionButton({
    super.key,
    required this.competitionId,
    required this.competitionData,
    required this.adherentCategorie,
  });

  bool estEligibilePourCompetition(String adherentCategorie) {
    // Vérifie si la catégorie de l'adhérent existe dans les données de la compétition
    return competitionData.containsKey(adherentCategorie.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InscriptionCompetitionBloc>(
      create: (context) => GetIt.I<InscriptionCompetitionBloc>(),
      child: Builder(
        builder: (context) => BlocListener<InscriptionCompetitionBloc,
            InscriptionCompetitionState>(
          listener: (context, state) {
            if (state is InscriptionCompetitionSuccess) {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: const Text('Inscription réussie'),
                    content: const Text(
                        'Votre inscription a été validée avec succès !'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else if (state is InscriptionCompetitionError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text('Échec de l\'inscription: ${state.errorMessage}'),
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

              if (!estEligibilePourCompetition(adherentCategorie)) {
                // Affiche un message si l'adhérent ne peut pas s'inscrire
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: const Text('Inscription impossible'),
                      content: Text(
                        'Votre catégorie ($adherentCategorie) ne correspond pas à celles disponibles pour cette compétition.',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
                return;
              }

              // Envoie l'inscription
              context.read<InscriptionCompetitionBloc>().add(
                    RegisterForCompetition(
                      competitionId: competitionId,
                      userId: user.uid,
                    ),
                  );

              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text(
                      'Inscription réussie',
                      style: textStyleText(context),
                    ),
                    content: Text(
                      'Votre inscription a été validée avec succès !',
                      style: textStyleText(context),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: Text(
                          'OK',
                          style: textStyleText(context),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
