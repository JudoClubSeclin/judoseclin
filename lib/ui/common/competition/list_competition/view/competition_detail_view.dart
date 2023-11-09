import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/ui/common/competition/inscription_competition/bloc/inscription_competition_bloc.dart';
import 'package:judoseclin/ui/common/competition/list_competition/interactor/competition_interactor.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';
import 'package:judoseclin/ui/common/widgets/buttons/custom_buttom.dart';

import '../../../../../domain/entities/competition.dart';
import '../../../widgets/images/image_fond_ecran.dart';
import '../../inscription_competition/bloc/inscription_competition_state.dart';

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
                CustomButton(
                  label: 'JE M\'INSCRIT',
                  onPressed: () async {
                    final bloc = context.read<InscriptionCompetitionBloc>();
                    await bloc.registerForCompetition(userId!, competitionId);

                    // Vérifiez si l'inscription a réussi
                    if (bloc.state is InscriptionCompetitionSuccess) {
                      // Affichez un message de succès ou effectuez d'autres actions
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Inscription réussie !'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
              ]));
            } else {
              return const Text('Détails de la compétition introuvables.');
            }
          },
        ),
      ),
    );
  }
}
