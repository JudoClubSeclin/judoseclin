import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/core/di/injection.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/competition/inscription_competition/competition_registration_button.dart';

import '../../../../domain/entities/competition.dart';
import '../../../../theme.dart';
import '../../../account/account_bloc.dart';
import '../../../account/account_event.dart';
import '../../../account/account_state.dart';
import '../../../account/adherents_session.dart';
import '../../inscription_competition/competition_Registration_bloc.dart';
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
  final accountBloc = getIt<AccountBloc>();
  final adherentId = getIt<AdherentSession>().getAdherent();


  @override
  void initState() {
    super.initState();

    // On déclenche le chargement utilisateur si pas déjà fait
    if (accountBloc.state is AccountInitial) {
      accountBloc.add(LoadUserInfo()); // userId déjà connu dans le bloc
    }
  }

  @override
  Widget build(BuildContext context) {
    if (adherentId == null) {
      return const Center(child: Text("Aucun adhérent sélectionné"));
    }
    debugPrint("CompetitionDetailView build() -> competitionId=${widget.competitionId}");
    debugPrint("AccountBloc state = ${accountBloc.state}");
    debugPrint("AdherentSession state = ${getIt<AdherentSession>().getAdherent()}");

    return BlocProvider(
      create: (_) => getIt<CompetitionRegistrationBloc>(
        param1: getIt<CompetitionRegistrationInteractor>(),
      ),
      child: Scaffold(
        appBar: const CustomAppBar(title: ''),
        drawer: MediaQuery.of(context).size.width > 750 ? null : const CustomDrawer(),
        body: Stack(
          children: [
            Positioned.fill(
              child: const DecoratedBox(
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

                  // On écoute l'état du compte
                  return BlocBuilder<AccountBloc, AccountState>(
                    bloc: accountBloc,
                    builder: (context, state) {
                      if (state is AccountLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is AccountLoaded) {
                        return _buildCompetitionDetails(
                          context,
                          competition,
                          state.userData['id'] as String?,
                        );
                      } else if (state is AccountError) {
                        return Center(child: Text('Erreur: ${state.message}'));
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompetitionDetails(BuildContext context, Competition competition, String? adherentId) {

    final adherentId = getIt<AdherentSession>().getAdherent();
    if (adherentId == null || adherentId.isEmpty) {
      return const Center(child: Text("Aucun adhérent sélectionné"));
    }
    debugPrint("AdherentSession state = ${getIt<AdherentSession>().getAdherent()}");
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(competition.title, style: titleStyleMedium(context), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text(competition.subtitle, style: titleStyleSmall(context), textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text(DateFormat('dd/MM/yyyy').format(competition.date), style: textStyleText(context)),
          Text(competition.address, style: textStyleText(context)),
          const SizedBox(height: 20),
          _buildCategoryInfo(context, 'Poussin', competition.poussin),
          _buildCategoryInfo(context, 'Benjamin', competition.benjamin),
          _buildCategoryInfo(context, 'Minime', competition.minime),
          _buildCategoryInfo(context, 'Cadet', competition.cadet),
          _buildCategoryInfo(context, 'Junior/Senior', competition.juniorSenior),
          _buildCategoryInfo(context, 'Ceinture minimum Poussin', competition.minBeltPoussin),
          _buildCategoryInfo(context, 'Ceinture minimum Benjamin', competition.minBeltBenjamin),
          _buildCategoryInfo(context, 'Ceinture minimum Minime', competition.minBeltMinime),
          _buildCategoryInfo(context, 'Ceinture minimum Cadet', competition.minBeltCadet),
          _buildCategoryInfo(context, 'Ceinture minimum Junior/Senior', competition.minBeltJuniorSenior),
          const SizedBox(height: 20),

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
              adherentId: adherentId,
              competitionDate: competition.date,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryInfo(BuildContext context, String category, String? info) {
    if (info == null || info.trim().isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        Text('$category: $info', style: textStyleText(context)),
        const SizedBox(height: 10),
      ],
    );
  }
}

