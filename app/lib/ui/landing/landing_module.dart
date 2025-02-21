import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:judoseclin/data/repository/competititon_repository_impl.dart';
import 'package:judoseclin/ui/ui_module.dart';

import '../../domain/entities/setup_entity_module.dart';
import 'landing.dart';

@singleton
class LandingModule implements UIModule {
  final AppRouter _appRouter;

  LandingModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/',
        builder: (context, state) => Landing(
          competitionRepository:
              CompetitionRepositoryImpl(getIt<FirestoreService>()),
        ),
      )
    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }
}
