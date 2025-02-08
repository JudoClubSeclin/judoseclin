import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/competition/list_competition/view/competition_detail_view.dart';

import '../../../core/di/injection.dart';
import '../../ui_module.dart';
import 'competition_bloc.dart';
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
          return MaterialPage(
            child: CompetitionDetailView(competitionId: competitionId, competitionInteractor: getIt<CompetitionInteractor>(),),
          );
        },
      ),

    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }

  Widget _buildDetailPage(String competitionId) {
    return BlocProvider<CompetitionBloc>(
      create: (context) {
        final interactor = getIt<CompetitionInteractor>();
        return CompetitionBloc(interactor, competitionId: competitionId);
      },
      child:  CompetitionDetailView(competitionId: '', competitionInteractor: getIt<CompetitionInteractor>(),),
    );
  }
}