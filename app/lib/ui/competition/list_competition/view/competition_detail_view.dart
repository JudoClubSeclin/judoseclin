import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/domain/entities/competition.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/competition/inscription_competition/inscription_button.dart';

import '../competition_interactor.dart';

class CompetitionDetailView extends StatelessWidget {
  final String competitionId;
  final CompetitionInteractor competitionInteractor;
  final Adherents adherents;

  const CompetitionDetailView({
    super.key,
    required this.competitionId,
    required this.competitionInteractor,
    required this.adherents,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: ''),
      drawer: MediaQuery.of(context).size.width > 750 ? null : const CustomDrawer(),
      body: Stack(
        children: [
          Positioned.fill( // Assure que l'image prend tout l'écran
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImageFondEcran.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: FutureBuilder<Competition?>(
              future: competitionInteractor.getCompetitionById(competitionId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erreur : ${snapshot.error}',
                      style: textStyleText(context),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: Text(
                      'Détails de la compétition introuvables.',
                      style: textStyleText(context),
                    ),
                  );
                }

                final competition = snapshot.data!;
                return _buildCompetitionDetails(context, competition);
              },
            ),
          ),
        ],
      ),

    );
  }

  Widget _buildCompetitionDetails(BuildContext context, Competition competition) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            competition.title,
            style: titleStyleMedium(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            competition.subtitle,
            style: titleStyleSmall(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            DateFormat('dd/MM/yyyy').format(competition.date!),
            style: textStyleText(context),
            textAlign: TextAlign.center,
          ),
          Text(
            competition.address,
            style: textStyleText(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildCategoryInfo(context, 'Poussin', competition.poussin),
          _buildCategoryInfo(context, 'Benjamin', competition.benjamin),
          _buildCategoryInfo(context, 'Minime', competition.minime),
          _buildCategoryInfo(context, 'Cadet', competition.cadet),
          _buildCategoryInfo(context, 'Junior/Senior', competition.juniorSenior),
          const SizedBox(height: 20),
          InscriptionButton(
            competitionId: competition.id,
            competitionData: competition.toMap(),
            adherentCategorie: adherents.category, // Make sure this is not null
          )
        ],
      ),
    );
  }

  Widget _buildCategoryInfo(BuildContext context, String category, String info) {
    return Column(
      children: [
        Text(
          '$category: $info',
          style: textStyleText(context),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}