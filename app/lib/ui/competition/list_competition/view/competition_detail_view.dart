import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/core/di/injection.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/competition/inscription_competition/competition_registration_button.dart';

import '../../../../domain/entities/competition.dart';
import '../../../../theme.dart';
import '../../../account/adherents_session.dart';
import '../../inscription_competition/competition_registration_bloc.dart';
import '../../inscription_competition/competition_registration_interactor.dart';
import '../../inscription_competition/competition_registration_state.dart';
import '../competition_interactor.dart';

class CompetitionDetailView extends StatefulWidget {
  final String competitionId;
  final CompetitionInteractor competitionInteractor;

  const CompetitionDetailView({
    super.key,
    required this.competitionId,
    required this.competitionInteractor,
  });

  @override
  State<CompetitionDetailView> createState() => _CompetitionDetailViewState();
}

class _CompetitionDetailViewState extends State<CompetitionDetailView> {
  @override
  Widget build(BuildContext context) {
    final adherentId = getIt<AdherentSession>().getAdherent(); // peut être null si pas sélectionné

    debugPrint("CompetitionDetailView build() -> competitionId=${widget.competitionId}");
    debugPrint("AdherentSession state = $adherentId");

    return BlocProvider(
      create: (_) => getIt<CompetitionRegistrationBloc>(
        param1: getIt<CompetitionRegistrationInteractor>(),
      ),
      child: Scaffold(
        appBar: const CustomAppBar(title: ''),
        drawer: MediaQuery.of(context).size.width > 750 ? null : const CustomDrawer(),
        body: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImageFondEcran.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: FutureBuilder<Competition?>(
                future: widget.competitionInteractor.getCompetitionById(widget.competitionId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erreur : ${snapshot.error}', style: textStyleText(context)),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                      child: Text('Détails de la compétition introuvables.', style: textStyleText(context)),
                    );
                  }

                  final competition = snapshot.data!;
                  return _buildCompetitionDetails(context, competition, adherentId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompetitionDetails(BuildContext context, Competition competition, String? adherentId) {
    // On affiche TOUJOURS les infos de la compétition (public)
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(competition.title, style: titleStyleMedium(context), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              if (competition.subtitle.isNotEmpty)
                Text(competition.subtitle, style: titleStyleSmall(context), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text(DateFormat('dd/MM/yyyy').format(competition.date), style: textStyleText(context)),
              if (competition.address.isNotEmpty)
                Text(competition.address, style: textStyleText(context)),
              const SizedBox(height: 20),

              // Créneaux / catégories présentes
              _buildCategoryInfo(context, 'Poussin', competition.poussin),
              _buildCategoryInfo(context, 'Benjamin', competition.benjamin),
              _buildCategoryInfo(context, 'Minime', competition.minime),
              _buildCategoryInfo(context, 'Cadet', competition.cadet),
              _buildCategoryInfo(context, 'Junior/Senior', competition.juniorSenior),

              // Ceintures minimales (affichées seulement si définies)
              _buildCategoryInfo(context, 'Ceinture minimum Poussin', competition.minBeltPoussin),
              _buildCategoryInfo(context, 'Ceinture minimum Benjamin', competition.minBeltBenjamin),
              _buildCategoryInfo(context, 'Ceinture minimum Minime', competition.minBeltMinime),
              _buildCategoryInfo(context, 'Ceinture minimum Cadet', competition.minBeltCadet),
              _buildCategoryInfo(context, 'Ceinture minimum Junior/Senior', competition.minBeltJuniorSenior),

              const SizedBox(height: 24),

              // Messages d'aide (facultatifs)
              if (adherentId == null || adherentId.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Connectez-vous et sélectionnez un adhérent pour vous inscrire.",
                    style: textStyleText(context),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Bouton d'inscription : les vérifs (connexion + règles) se font DANS le bouton
              BlocListener<CompetitionRegistrationBloc, CompetitionRegistrationState>(
                listener: (context, state) {
                  if (state is CompetitionRegistrationLoading) {
                    debugPrint("Bloc: Inscription en cours...");
                  } else if (state is CompetitionRegistrationSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Inscription réussie !')),
                    );
                  } else if (state is CompetitionRegistrationFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur : ${state.message}')),
                    );
                  }
                },
                child: InscriptionButton(
                  competitionId: competition.id,
                  adherentId: (adherentId ?? ''),
                  competitionDate: competition.date,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryInfo(BuildContext context, String label, String? value) {
    if (value == null || value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text('$label: $value', style: textStyleText(context)),
    );
  }
}
