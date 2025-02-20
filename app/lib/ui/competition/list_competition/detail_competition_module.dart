import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/ui/competition/list_competition/view/competition_detail_view.dart';

import '../../../core/di/injection.dart';
import '../../ui_module.dart';
import 'competition_interactor.dart';

@singleton
class CompetitionDetailModule implements UIModule {
  final AppRouter _appRouter;

  CompetitionDetailModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/competition/:id',
        pageBuilder: (context, state) {
          final competitionId = state.pathParameters['id'] ?? '';
          final adherents = getIt<Adherents>();
          return MaterialPage(
            child: CompetitionDetailView(
              competitionId: competitionId,
              competitionInteractor: getIt<CompetitionInteractor>(),
              adherents: adherents,
            ),
          );
        },
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }
}