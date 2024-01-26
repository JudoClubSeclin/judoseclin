import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/domain/usecases/adherents/fetch_adherents_data_usecase.dart';
import 'package:judoseclin/domain/usecases/competitions/fetch_competitions_data_usecase.dart';
import 'package:judoseclin/domain/usecases/cotisation/fetch_cotisation_data_usecase.dart';
import 'package:judoseclin/landing.dart';
import 'package:judoseclin/ui/common/account/view/account_view.dart';
import 'package:judoseclin/ui/common/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/common/adherents/view/adherents_detail_view.dart';
import 'package:judoseclin/ui/common/adherents/view/list_adherents_view.dart';
import 'package:judoseclin/ui/common/competition/add_competition/view/add_competition_view.dart';
import 'package:judoseclin/ui/common/competition/list_competition/interactor/competition_interactor.dart';
import 'package:judoseclin/ui/common/competition/list_competition/view/competition_list_view.dart';
import 'package:judoseclin/ui/common/cotisations/interactor/cotisation_interactor.dart';
import 'package:judoseclin/ui/common/members/inscription/view/inscription_view.dart';

import '../account/bloc/account_bloc.dart';
import '../account/interactor/account_interactor.dart';
import '../adherents/view/add_adherents_view.dart';
import '../competition/list_competition/view/competition_detail_view.dart';
import '../cotisations/view/add_cotisation_view.dart';
import '../members/login/view/login_view.dart';
import '../members/login/view/reset_password_view.dart';

final goRouter = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Landing(),
      routes: [
        GoRoute(
          path: 'competitions',
          builder: (context, state) => const CompetitionsListView(),
          routes: [
            GoRoute(
              path: ':competitionId',
              builder: (BuildContext context, GoRouterState state) {
                final competitionId = state.pathParameters['competitionId'];
                var fetchCompetitionDataUseCase = FetchCompetitionDataUseCase();
                var interactor =
                    CompetitionInteractor(fetchCompetitionDataUseCase);
                if (competitionId != null) {
                  debugPrint(competitionId);
                  return CompetitionDetailView(
                    competitionId: competitionId,
                    competitionInteractor: interactor,
                  );
                } else {
                  return const Center(
                    child: Text("Erreur : ID des détails manquant"),
                  );
                }
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
        path: '/admin/add/competition',
        builder: (context, state) => AddCompetitionView()),
    GoRoute(
        path: '/admin/add/adherents',
        builder: (context, state) => AddAdherentsView()),
    GoRoute(
      path: '/admin/list/adherents',
      builder: (context, state) => const ListAdherentsView(),
      routes: [
        GoRoute(
          path: ':adherentsId', // Modifiez le chemin ici
          builder: (BuildContext context, GoRouterState state) {
            final adherentsId = state.pathParameters['adherentsId'];
            var fetchAdherentsDataUseCase = FetchAdherentsDataUseCase();
            var fetchCotisationDataUseCase = FetchCotisationDataUseCase();
            var firestore = FirebaseFirestore.instance;
            var interactor =
                AdherentsInteractor(fetchAdherentsDataUseCase, firestore);
            var cotisationInteractor =
                CotisationInteractor(fetchCotisationDataUseCase, firestore);
            if (adherentsId != null) {
              debugPrint(adherentsId);
              return AdherentsDetailView(
                adherentId: adherentsId,
                adherentsInteractor: interactor,
                cotisationInteractor: cotisationInteractor,
              );
            } else {
              return const Center(
                child: Text('Erreur: Id des détails manquant'),
              );
            }
          },
        ),
      ],
    ),
    GoRoute(
        path: '/admin/add/cotisation/:adherentId',
        builder: (BuildContext context, GoRouterState state) {
          final adherentId = state.pathParameters['adherentId'];
          if (adherentId != null) {
            debugPrint(adherentId);
            return AddCotisationView(adherentId: adherentId);
          } else {
            return const Text('l\'id est manquant');
          }
        }),
    GoRoute(
      path: '/account',
      pageBuilder: (context, state) => MaterialPage(
        child: BlocProvider<AccountBloc>(
          create: (BuildContext context) {
            var interactor = AccountInteractor();
            return AccountBloc(accountInteractor: interactor);
          },
          child: const AccountView(),
        ),
      ),
      routes: [
        GoRoute(
          path: 'login',
          builder: (context, state) => LoginView(),
        ),
        GoRoute(
          path: 'inscription',
          builder: (context, state) => InscriptionView(),
        ),
        GoRoute(
          path: 'resetPassword',
          builder: (context, state) => ResetPasswordView(),
        ),
      ],
    ),
  ],
);
