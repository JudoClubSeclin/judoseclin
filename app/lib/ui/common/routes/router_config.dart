import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/data/repository/cotisation_repository/cotisation_repository.dart';
import 'package:judoseclin/data/repository/user_repository/user_repository.dart';
import 'package:judoseclin/domain/usecases/adherents/fetch_adherents_data_usecase.dart';
import 'package:judoseclin/domain/usecases/competitions/fetch_competitions_data_usecase.dart';
import 'package:judoseclin/domain/usecases/cotisation/fetch_cotisation_data_usecase.dart';
import 'package:judoseclin/ui/account/view/account_page.dart';
import 'package:judoseclin/ui/landing/landing.dart';

import '../../../data/repository/adherents_repository/adherents_repository.dart';
import '../../../data/repository/competition_repository/competition_repository.dart';
import '../../account/bloc/account_bloc.dart';
import '../../account/interactor/account_interactor.dart';
import '../../adherents/interactor/adherents_interactor.dart';
import '../../adherents/view/add_adherents_view.dart';
import '../../adherents/view/adherents-detail/adherents_detail_view.dart';
import '../../adherents/view/list_adherents_view.dart';
import '../../competition/add_competition/view/add_competition_view.dart';
import '../../competition/list_competition/interactor/competition_interactor.dart';
import '../../competition/list_competition/view/competition_detail_view.dart';
import '../../competition/list_competition/view/competition_list_view.dart';
import '../../cotisations/interactor/cotisation_interactor.dart';
import '../../cotisations/view/add_cotisation_view.dart';
import '../../members/inscription/view/inscription_view.dart';
import '../../members/login/view/login_view.dart';
import '../../members/login/view/reset_password_view.dart';

AdherentsRepository adherentsRepository = ConcretedAdherentsRepository();

final goRouter = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Landing(),
      routes: [
        GoRoute(
          path: 'competitions',
          builder: (context, state) => const CompetitionsListView(),
          routes: [
            GoRoute(
              path: ':competitionId',
              builder: (BuildContext context, GoRouterState state) {
                final CompetitionRepository competitionRepository =
                    ConcretedCompetitionRepository();
                final competitionId = state.pathParameters['competitionId'];
                var fetchCompetitionDataUseCase =
                    FetchCompetitionDataUseCase(competitionRepository);
                var interactor = CompetitionInteractor(
                    fetchCompetitionDataUseCase, competitionRepository);
                if (competitionId != null) {
                  debugPrint(competitionId);
                  return CompetitionDetailView(
                    competitionId: competitionId,
                    competitionInteractor: interactor,
                  );
                } else {
                  return const Center(
                    child: Text("Erreur : ID des détailsmanquant"),
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
        builder: (context, state) =>
            const AddCompetitionView(publishDate: null)),
    GoRoute(
      path: '/admin/add/adherents',
      builder: (context, state) => AddAdherentsView(
        adherentsRepository: adherentsRepository,
      ),
    ),
    GoRoute(
      path: '/admin/list/adherents',
      builder: (context, state) {
        var fetchAdherentsDataUseCase =
            FetchAdherentsDataUseCase(adherentsRepository);
        var interactor =
            AdherentsInteractor(fetchAdherentsDataUseCase, adherentsRepository);

        return ListAdherentsView(
          interactor: interactor,
        );
      },
      routes: [
        GoRoute(
          path: ':adherentsId',
          builder: (BuildContext context, GoRouterState state) {
            final adherentsId = state.pathParameters['adherentsId'];
            var cotisationRepository = ConcretedCotisationRepository();
            var fetchAdherentsDataUseCase =
                FetchAdherentsDataUseCase(adherentsRepository);
            var fetchCotisationDataUseCase =
                FetchCotisationDataUseCase(cotisationRepository);
            var interactor = AdherentsInteractor(
                fetchAdherentsDataUseCase, adherentsRepository);
            var cotisationInteractor = CotisationInteractor(
                fetchCotisationDataUseCase, cotisationRepository);
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
            UsersRepository userRepository = ConcretedUserRepository();
            var userId = '';
            var interactor = AccountInteractor(userRepository, userId);

            return AccountBloc(
              accountInteractor: interactor, userId: '',
              // Assurez-vous de fournir le vrai userId ici
            );
          },
          child: const AccountPage(),
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
