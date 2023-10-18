// router_config.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/landing.dart';
import 'package:judoseclin/ui/common/account/view/account_view.dart';
import 'package:judoseclin/ui/common/competition_info/view/screen/competitions_list_screen.dart';
import 'package:judoseclin/ui/common/members/inscription/view/inscription_view.dart';

import '../account/bloc/account_bloc.dart';
import '../account/interactor/account_interactor.dart';
import '../members/login/view/login_view.dart';
import '../members/login/view/resetPassword_view.dart';

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
      builder: (context, state) => InscriptionView(),
    ),
    GoRoute(
      path: '/resetPassword',
      builder: (context, state) => ResetPasswordView(),
    ),
    GoRoute(
      path: '/account',
      pageBuilder: (context, state) => MaterialPage(
        child: BlocProvider<AccountBloc>(
          create: (BuildContext context) {
            var interactor = AccountInteractor(
                auth: FirebaseAuth.instance,
                firestore: FirebaseFirestore.instance);
            return AccountBloc(accountInteractor: interactor);
          },
          child: const AccountView(),
        ),
      ),
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
