import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import 'package:judoseclin/ui/competition/list_competition/competition_bloc.dart';
import 'package:judoseclin/ui/competition/list_competition/view/competition_list_view.dart';
import 'package:judoseclin/ui/ui_module.dart';

import '../../../core/di/injection.dart';
import '../../../data/repository/competition_repository.dart';
import '../../members/login/view/login_view.dart';

@singleton
class ListCompetitionModule implements UIModule {
  final AppRouter _appRouter;

  ListCompetitionModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/competition',
        pageBuilder: (context, state) {
          return MaterialPage(child: _buildAccountPage());
        },
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }

  Widget _buildAccountPage() {
    final String? userId = getIt<FirebaseAuth>().currentUser?.uid;

    if (userId != null) {
      return BlocProvider<CompetitionBloc>(
        create: (context) {
          final repository = getIt<CompetitionRepository>();
          return CompetitionBloc(repository);
        },
        child:  CompetitionsListView(),
      );
    } else {
      return BlocProvider<CompetitionBloc>(
        create: (_) => CompetitionBloc(
          getIt<CompetitionRepository>(),
        ),
        child: LoginView(),
      );
    }
  }
}
