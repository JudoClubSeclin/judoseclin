// router_config.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/domain/usecases/competitions/fetch_competitions_data_usecase.dart';
import 'package:judoseclin/landing.dart';
import 'package:judoseclin/ui/common/account/view/account_view.dart';
import 'package:judoseclin/ui/common/competition/list_competition/interactor/competition_interactor.dart';
import 'package:judoseclin/ui/common/competition/list_competition/view/competition_list_view.dart';
import 'package:judoseclin/ui/common/members/inscription/view/inscription_view.dart';

import '../account/bloc/account_bloc.dart';
import '../account/interactor/account_interactor.dart';
import '../competition/list_competition/view/competition_detail_view.dart';
import '../members/login/view/login_view.dart';
import '../members/login/view/resetPassword_view.dart';

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
