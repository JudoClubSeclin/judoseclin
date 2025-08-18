import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/theme.dart';

import '../../../core/di/injection.dart';
import '../../competition/inscription_competition/competition_Registration_bloc.dart';
import '../../competition/inscription_competition/competition_registration_event.dart';
import '../../competition/inscription_competition/competition_registration_state.dart';

class CompetitionRegister extends StatelessWidget {
  final String adherentId;
  final String competitionId;
  const CompetitionRegister({super.key, required this.adherentId, required this.competitionId});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // L'utilisateur n'est pas connecté
      return ElevatedButton(
        onPressed: () {
          context.go('/login');
        },
        child: const Text('Connectez-vous pour vous inscrire'),
      );
    }

    // Si connecté, continuer avec le Bloc
    return BlocProvider(
      create: (_) => getIt<CompetitionRegistrationBloc>()
        ..add(CheckRegistrationStatusEvent(
          adherentId: adherentId,
          competitionId: competitionId,
        )),
      child: BlocBuilder<CompetitionRegistrationBloc, CompetitionRegistrationState>(
        builder: (context, state) {
          if (state is CompetitionRegistrationLoading) {
            return const CircularProgressIndicator();
          } else if (state is RegistrationStatusChecked) {
            return Text(
              state.isRegistered
                  ? 'Je suis inscrit à cette compétition.'
                  : 'Je ne suis pas inscrit à cette compétition.',
              style: textStyleText(context),
            );
          } else if (state is CompetitionRegistrationFailure) {
            return Text(
              'Erreur: ${state.message}',
              style: const TextStyle(color: Colors.red),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

}
