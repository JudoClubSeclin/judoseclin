import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:landing_page/landing_page.dart' deferred as landing_page;
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
        path: '/', // 👈 route principale
        builder: (context, state) => FutureBuilder(
          future: () async {
            await landing_page.loadLibrary();
            await landing_page.WithImageOnly.precacheImages(context);
          }(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return landing_page.WithImageOnly(); // 👈 ton widget de la feature
            } else {
              return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }
}
