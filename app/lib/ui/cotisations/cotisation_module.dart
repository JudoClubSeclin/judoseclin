import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/cotisations/cotisation_interactor.dart';
import 'package:judoseclin/ui/cotisations/view/add_cotisation_view.dart';
import 'package:judoseclin/ui/ui_module.dart';

import '../../../core/di/injection.dart';
import 'cotisation_bloc.dart';

@singleton
class CotisationModule implements UIModule {
  final AppRouter _appRouter;

  CotisationModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/admin/add/cotisation/:adherentId',
        pageBuilder: (context, state) {
          final adherentId = state.pathParameters['adherentId'] ?? '';
          return MaterialPage(
            child: _buildAccountPage(adherentId),
          );
        },
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }


  Widget _buildAccountPage(String adherentId) {
    final interactor = getIt<CotisationInteractor>();
    return BlocProvider<CotisationBloc>(
      create: (context) {
        return CotisationBloc(
          adherentId: adherentId,
          cotisationInteractor: interactor,
        );
      },
      child: AddCotisationView(adherentId: adherentId),
    );
  }
}
