import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../domain/entities/competition.dart';
import '../../../theme/theme.dart';
import '../../../widgets/appbar/custom_appbar.dart';
import '../../../widgets/buttons/custom_buttom.dart';
import '../../../widgets/images/image_fond_ecran.dart';
import '../bloc/competition_bloc.dart';
import '../bloc/competition_state.dart';

class CompetitionDetailView extends StatelessWidget {
  final String competitionId;

  const CompetitionDetailView({
    Key? key,
    required this.competitionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupérez le bloc de compétition depuis le context
    final competitionBloc = BlocProvider.of<CompetitionBloc>(context);

    return FutureBuilder<Competition?>(
        future: competitionBloc.getCompetitionById(competitionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erreur : ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Text('Détails de la compétition introuvables.');
          } else {
            final competitionDetails = snapshot.data;

            return Scaffold(
              appBar: const CustomAppBar(
                title: 'Détails de la compétition',
              ),
              body: BlocBuilder<CompetitionBloc, CompetitionState>(
                builder: (context, state) {
                  if (state is CompetitionLoaded) {
                    final competitionDetails = state.competitionData.firstWhere(
                      (comp) => comp.id == competitionId,
                      orElse: () => Competition(
                        id: 'N/A',
                        address: Geocode(longitude: 0.0, latitude: 0.0),
                        titre: 'N/A',
                        sousTitre: 'Sous-titre de la compétition',
                        debut: DateTime.now(),
                        fin: DateTime.now(),
                        limiteInscription: DateTime.now(),
                        description: ['Description introuvable.'],
                      ),
                    );

                    final String titre = competitionDetails.titre;
                    final String sousTitre = competitionDetails.sousTitre;
                    final DateTime debut = competitionDetails.debut;
                    final DateTime fin = competitionDetails.fin;
                    final DateTime limiteInscription =
                        competitionDetails.limiteInscription;
                    final Geocode address = competitionDetails.address;
                    final List<String> descriptions =
                        competitionDetails.description;

                    // Créez une chaîne de texte à partir de la liste de descriptions
                    String descriptionText = descriptions.join('\n');

                    return Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(ImageFondEcran.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                titre,
                                style: titleStyleMedium(context),
                              ),
                              const SizedBox(height: 22),
                              Text(
                                sousTitre,
                                style: titleStyleMedium(context),
                              ),
                              const SizedBox(height: 22),
                              Text(
                                DateFormat('dd/MM/yyyy').format(debut),
                                style: titleStyleMedium(context),
                              ),
                              const SizedBox(height: 22),
                              Text(
                                'Position : ${address.longitude}, ${address.latitude}',
                                style: titleStyleMedium(context),
                              ),
                              const SizedBox(height: 22),
                              Text(
                                'Fin : ${DateFormat('dd/MM/yyyy').format(fin)}',
                                style: titleStyleMedium(context),
                              ),
                              const SizedBox(height: 22),
                              Text(
                                'Limite d\'inscription : ${DateFormat('dd/MM/yyyy').format(limiteInscription)}',
                                style: titleStyleMedium(context),
                              ),
                              const SizedBox(height: 22),
                              Text(
                                descriptionText,
                                style: titleStyleMedium(context),
                              ),
                              const SizedBox(height: 40),
                              CustomButton(
                                label: "JE M'INSCRIS",
                                onPressed: () {
                                  // Vous pouvez ajouter ici la logique pour inscrire l'utilisateur à la compétition
                                  // Assurez-vous d'utiliser userId et competitionDetails le cas échéant.
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  } else if (state is CompetitionLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is CompetitionError) {
                    return Text('Erreur : ${state.message}');
                  } else {
                    return const Center(
                      child: Text("État inconnu"),
                    );
                  }
                },
              ),
            );
          }
        });
  }
}
