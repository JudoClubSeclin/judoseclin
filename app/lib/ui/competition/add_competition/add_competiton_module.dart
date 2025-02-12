import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/competition/add_competition/view/add_competition_view.dart';

import '../../../core/di/injection.dart';
import '../../ui_module.dart';
import '../list_competition/competition_interactor.dart';
import 'add_competition_bloc.dart';

@singleton
class AddCompetitionModule implements UIModule {
  final AppRouter _appRouter;

  AddCompetitionModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/admin/add/competition',
        pageBuilder: (context, state) {
          final interactor = getIt<CompetitionInteractor>();

          return MaterialPage(
            child: BlocProvider(
              create: (context) => AddCompetitionBloc(interactor),
              child: AddCompetitionView(publishDate: null),
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
