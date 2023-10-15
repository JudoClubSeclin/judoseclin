// router_config.dart

import 'package:go_router/go_router.dart';
import 'package:judoseclin/landing.dart';
import 'package:judoseclin/ui/common/competition_info/view/screen/competitions_list_screen.dart';
import 'package:judoseclin/ui/common/connexion_to_firebase/inscription.dart';
import 'package:judoseclin/ui/common/landing_page_account/landing_account.dart';
import 'package:judoseclin/ui/common/members/view/login_view.dart';

final goRouter = GoRouter(
  debugLogDiagnostics: true,
  /*redirect: (BuildContext context, GoRouterState state) {
    if (FirebaseAuth.instance.currentUser == null && state.uri.path != '/') {
      return '/'; // Redirige vers l'écran `Landing` si l'utilisateur n'est pas connecté
    }
    return null; // Continue normalement
  },*/
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Landing(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: '/connexion',
      builder: (context, state) => LoginView(),
    ),
    GoRoute(
      path: '/inscription',
      builder: (context, state) => Inscription(),
    ),
    GoRoute(
      path: '/account',
      builder: (context, state) => const LandingAccount(),
    ),
    GoRoute(
      path: '/ListCompetition',
      builder: (context, state) => const CompetitionsListScreen(),
    ),
    /*GoRoute(
      path: '/details/:detailsId',
      builder: (context, state) {
        final detailsId = state.pathParameters['detailsId'];
        if (detailsId != null) {
          return CompetitionDetailsScreen(
            id: detailsId,
            competition: null,
          );
        } else {
          return const Center(
            child: Text("Erreur : ID des détails manquant"),
          );
        }
      },
    ),*/
  ],
);
