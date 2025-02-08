import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';

import '../../../../../domain/entities/competition.dart';
import '../../../common/widgets/images/image_fond_ecran.dart';
import '../../inscription_competition/inscription_button.dart';
import '../competition_interactor.dart';

class CompetitionDetailView extends StatelessWidget {
  final String competitionId;
  final CompetitionInteractor competitionInteractor;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  CompetitionDetailView({
    required this.competitionId,
    required this.competitionInteractor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      drawer: MediaQuery.sizeOf(context).width > 750 ? null : CustomDrawer(),
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
                return Text('Erreur : ${snapshot.error}',style: textStyleText(context),);
              }

              final competition = snapshot.data;

              if (competition != null) {
                debugPrint(competition.toString());

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
                      style: titleStyleSmall(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(competition.date!),
                    style: textStyleText(context),
                    textAlign: TextAlign.center,
                  ),
                  Text(competition.address,
                      style: textStyleText(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(competition.poussin,
                      style: textStyleText(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(competition.benjamin,
                      style: textStyleText(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(competition.minime,
                      style: textStyleText(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),

                  Text(competition.cadet,
                      style: textStyleText(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(competition.juniorSenior,
                      style: textStyleText(context),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  // ConfigurationLocale.instance.peutSeConnecter &&

                      InscriptionButton(competitionId: competitionId),
                ]));
              } else {
                return const Text('Détails de la compétition introuvables.');
              }
            }),
      ),
    );
  }
}
