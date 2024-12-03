import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/landing_page/landing_home.dart';
import 'package:judoseclin/ui/ui_module.dart';

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
          path:'/',
      builder: (context, state) => const LandingHome(),
      )
    ];
  }
  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }

}