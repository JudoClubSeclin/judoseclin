import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/configuration_locale.dart';
import 'package:judoseclin/ui/common/competition/inscription_competition/bloc/inscription_competition_bloc.dart';
import 'package:judoseclin/ui/common/competition/list_competition/interactor/competition_interactor.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';
import 'package:judoseclin/ui/common/widgets/buttons/custom_buttom.dart';

import '../../../../../domain/entities/competition.dart';
import '../../../widgets/images/image_fond_ecran.dart';
import '../../inscription_competition/bloc/inscription_competition_event.dart';

class CompetitionDetailView extends StatelessWidget {
  final String competitionId;
  final CompetitionInteractor competitionInteractor;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  CompetitionDetailView({
    required this.competitionId,
    required this.competitionInteractor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la compétition'),
      ),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageFondEcran.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<Competition?>(
            future: competitionInteractor.getCompetitionById(competitionId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                debugPrint('je passe -1');
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Erreur : ${snapshot.error}');
              }

              final competition = snapshot.data;

              if (competition != null) {
                debugPrint(competition.toString());

                Timestamp timestamp = competition.date;
                DateTime date = timestamp.toDate();
                String formattedDate = DateFormat('dd/MM/yyyy').format(date);

                return Center(
                    child: ListView(children: [
                  Text(
                    competition.title,
                    style: titleStyleMedium(context),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(competition.subtitle,
                      style: titleStyleMedium(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(formattedDate,
                      style: titleStyleSmall(context),
                      textAlign: TextAlign.center),
                  Text(competition.address,
                      style: titleStyleSmall(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(competition.poussin,
                      style: titleStyleSmall(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(competition.benjamin,
                      style: titleStyleSmall(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(competition.minime,
                      style: titleStyleSmall(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  ConfigurationLocale.instance.peutSeConnecter
                      ? CustomButton(
                          label: 'JE M\'INSCRIS',
                          onPressed: () async {
                            User? user = FirebaseAuth.instance.currentUser;

                            if (user != null) {
                              final bloc =
                                  context.read<InscriptionCompetitionBloc>();
                              bloc.add(RegisterForCompetition(
                                  competitionId: competitionId,
                                  userId: userId!));

                              // Le bloc émettra l'état de succès, vous pouvez ici afficher le dialogue si nécessaire
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
                            } else {
                              context.go('/account/login');
                            }
                          },
                        )
                      : const SizedBox()
                ]));
              } else {
                return const Text('Détails de la compétition introuvables.');
              }
            }),
      ),
    );
  }
}
