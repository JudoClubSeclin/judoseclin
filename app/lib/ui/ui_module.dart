import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

abstract class UIModule {
  void configure();

  ///Méthode pour obtenir les routes du module
  List<RouteBase> getRoutes();

  ///Méthode pour obtenir les widgets partagés du module(si nécessaire)
  Map<String, WidgetBuilder> getShareWidgets();
}

///Mixin pour fournir une implémentation par defaut de getShareWidgets

mixin DefaultShareWidgets on UIModule {
  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }

  /// Nouvelle méthode pour envelopper un widget avec les providers nécessaires
  Widget wrapWithProviders(BuildContext context, Widget child);
}

/// class pour gérer les routes de l'application

@singleton
class AppRouter {
  final List<RouteBase> _routes = [];

  void addRoutes(List<RouteBase> routes) {
    _routes.addAll(routes);
  }

  List<RouteBase> get routes => _routes;
}

///onction pour créer le routeur Go
GoRouter createRouter(AppRouter appRouter) {
  return GoRouter(routes: appRouter.routes);
}
