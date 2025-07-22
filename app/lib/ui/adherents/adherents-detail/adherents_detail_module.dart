import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/ui/adherents/adherents-detail/adherents_detail_view.dart';
import 'package:judoseclin/ui/adherents/adherents_bloc.dart';
import 'package:judoseclin/ui/adherents/adherents_interactor.dart';
import 'package:judoseclin/ui/cotisations/cotisation_interactor.dart';

import '../../../core/di/api/auth_service.dart';
import '../../../core/di/api/firestore_service.dart';
import '../../../core/di/injection.dart';
import '../../ui_module.dart';

@singleton
class AdherentsDetailModule implements UIModule {
  final AppRouter _appRouter;

  AdherentsDetailModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    //debugPrint("🚀 Route générée : /admin/adherents/:id");
    return [
      GoRoute(
        name: 'adherents_detail',
        path: '/admin/adherents/:id',
        pageBuilder: (context, state) {
          final adherentId = state.pathParameters['id'];
          debugPrint("🛠 ID après GoRouter (named route) : $adherentId");

          if (adherentId == null || adherentId.isEmpty) {
            return const MaterialPage(
              child: Scaffold(
                body: Center(child: Text("⚠️ Erreur: ID manquant")),
              ),
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

  /// ✅ Correction : `_buildDetailPage` retourne une `Page<dynamic>` et non un `Widget`
  Page<dynamic> _buildDetailPage(String adherentId) {
    debugPrint("✅ ID reçu dans AdherentsDetailModule: $adherentId");
    final interactor = getIt<AdherentsInteractor>();
    final cotisationInteractor = getIt<CotisationInteractor>();
    final auth = getIt<AuthService>();
    final firestoreService = getIt<FirestoreService>();
    final adherent = getIt<Adherents>();

    return CustomTransitionPage(
      child: BlocProvider<AdherentsBloc>(
        create:
            (context) => AdherentsBloc(
              interactor,
              auth,
              firestoreService,
              adherentId: adherentId,
            ),
        child: AdherentsDetailView(
          adherentId: adherentId,
          adherentsInteractor: interactor,
          cotisationInteractor: cotisationInteractor,
          adherent: adherent,
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
