import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/ui_module.dart';
import 'package:landing_page/landing_page.dart' deferred as landing_page;

import '../../core/di/api/firestore_service.dart';
import '../../core/di/injection.dart';
import '../../data/repository/competition_repository_impl.dart';
import 'landing.dart';

@singleton
class LandingModule implements UIModule {
  final AppRouter _appRouter;

  LandingModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  Future<void> loadLandingPage() async {}

  @override
  List<RouteBase> getRoutes() {
    return [
      ?(kDebugMode)
          ? null
          : GoRoute(
              path: '/',
              builder: (context, state) => Landing(
                competitionRepository: CompetitionRepositoryImpl(
                  getIt<FirestoreService>(),
                ),
              ),
            ),
      ?(kDebugMode)
          ? GoRoute(
              path: '/',
              builder: (context, state) => FutureBuilder(
                future: () async {
                  await landing_page.loadLibrary();
                  await landing_page.WithImageOnly.precacheImages(context);
                }(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return landing_page.WithImageOnly();
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
            )
          : null,
    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }
}
