import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/ui/account/account_bloc.dart';
import 'package:judoseclin/ui/account/account_interactor.dart';
import 'package:judoseclin/ui/account/compte_adherent/compte_adherent_view.dart';
import 'package:judoseclin/ui/account/view/account_page.dart';
import 'package:judoseclin/ui/adherents/adherents_bloc.dart';
import 'package:judoseclin/ui/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/ui_module.dart';
import 'package:provider/provider.dart';

import '../../../core/di/api/auth_service.dart';
import '../../../core/di/injection.dart';

@singleton
class CompteAdherentsModule implements UIModule {
  final AppRouter _appRouter;

  CompteAdherentsModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        name: 'mes_donnees',
        path: '/adherents/:id',
        pageBuilder: (context, state) {
          final adherentId = state.pathParameters['id']!;
          if (adherentId == null || adherentId.isEmpty) {
            return const MaterialPage(
              child: Scaffold(
                  body: Center(child: Text("⚠️ Erreur: ID manquant"))),
            );
          }

          return _buildDetailPage(adherentId);
        },
      ),

    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }

  Page<dynamic> _buildDetailPage(String adherentId) {
    final adherentsInteractor = getIt<AdherentsInteractor>();
    final _authService = getIt<AuthService>();
    final adherent = getIt<Adherents>();
    final _firestoreService = getIt<FirestoreService>();

    return CustomTransitionPage(
      child: BlocProvider<AdherentsBloc>(
        create: (context) =>
            AdherentsBloc(
                adherentsInteractor,
                _authService,
                _firestoreService,
                adherentId: adherentId
            ),
        child: CompteAdherentView(adherentId: adherentId,),

      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}



