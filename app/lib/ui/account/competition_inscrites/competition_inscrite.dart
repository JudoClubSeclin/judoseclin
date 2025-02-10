import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import '../../../theme.dart';
import '../../competition/inscription_competition/inscription_competition_bloc.dart';
import '../../competition/inscription_competition/inscription_competition_event.dart';
import '../../competition/inscription_competition/inscription_competition_state.dart';

class CompetitionsInscrites extends StatefulWidget {
  const CompetitionsInscrites({super.key});

  @override
  CompetitionsInscritesState createState() => CompetitionsInscritesState();
}

class CompetitionsInscritesState extends State<CompetitionsInscrites> {
  late final InscriptionCompetitionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.I<InscriptionCompetitionBloc>();
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && _bloc.state is! InscriptionCompetitionLoaded) {
      _bloc.add(LoadUserInscriptions(userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child:
          BlocBuilder<InscriptionCompetitionBloc, InscriptionCompetitionState>(
        builder: (context, state) {
          if (state is InscriptionCompetitionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InscriptionCompetitionLoaded) {
            if (state.inscriptions.isEmpty) {
              return Text(
                'Je ne suis inscrit à aucune compétition.',
                style: textStyleText(context),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Je suis inscrit aux compétitions suivantes :',
                  style: textStyleText(context),
                ),
                const SizedBox(height: 5),
                ...state.inscriptions.map((competition) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "• ${competition.title}",
                      style: textStyleText(context),
                    ),
                  );
                }),
              ],
            );
          } else if (state is InscriptionCompetitionError) {
            return Text(
              'Erreur : ${state.errorMessage}',
              style: textStyleText(context),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  @override
  void dispose() {
    // Si nécessaire, vous pouvez nettoyer le bloc ici
    super.dispose();
  }
}
