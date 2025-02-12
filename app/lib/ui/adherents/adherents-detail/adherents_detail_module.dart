import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/adherents/adherents-detail/adherents_detail_view.dart';
import 'package:judoseclin/ui/adherents/adherents_bloc.dart';
import 'package:judoseclin/ui/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/cotisations/interactor/cotisation_interactor.dart';

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
    return [
      GoRoute(
        path: '/admin/add/adherents/:id',
        pageBuilder: (context, state) {
          final adherentId = state.pathParameters['id'] ?? '';
          return _buildDetailPage(
              adherentId); // ✅ Correction : Retourne une Page et non un Widget
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
    final interactor = getIt<AdherentsInteractor>();
    final cotisationInteractor = getIt<CotisationInteractor>();

    return CustomTransitionPage(
      child: BlocProvider<AdherentsBloc>(
        create: (context) => AdherentsBloc(
          interactor,
          adherentId: adherentId,
        ),
        child: AdherentsDetailView(
          adherentId: adherentId,
          adherentsInteractor: interactor,
          cotisationInteractor: cotisationInteractor,
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
