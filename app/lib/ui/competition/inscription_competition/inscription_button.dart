import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/theme.dart';

import '../../common/widgets/buttons/custom_buttom.dart';
import 'inscription_competition_bloc.dart';
import 'inscription_competition_event.dart';
import 'inscription_competition_state.dart';
// Importez vos fichiers de bloc, d'états et d'événements

class InscriptionButton extends StatelessWidget {
  final String competitionId;

  const InscriptionButton({Key? key, required this.competitionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InscriptionCompetitionBloc>(
      create: (context) => GetIt.I<InscriptionCompetitionBloc>(),
      child: Builder(
        builder: (context) => BlocListener<InscriptionCompetitionBloc, InscriptionCompetitionState>(
          listener: (context, state) {
            if (state is InscriptionCompetitionSuccess) {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: const Text('Inscription réussie'),
                    content: const Text('Votre inscription a été validée avec succès !'),
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
              // Gérer l'échec de l'inscription ici
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Échec de l\'inscription: ${state.errorMessage}')),
              );
            }
          },
          child: CustomButton(
            label: 'JE M\'INSCRIS',
            onPressed: () async {
              User? user = FirebaseAuth.instance.currentUser;

              if (user != null) {
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
                      title:  Text('Inscription réussie',style: textStyleText(context),),
                      content:  Text(
                          'Votre inscription a été validée avec succès !', style: textStyleText(context),),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                          },
                          child:  Text('OK', style: textStyleText(context),),
                        ),
                      ],
                    );
                  },
                );
              } else {
                context.go('/login');
              }
            },
          ),
        ),
      ),
    );
  }
}