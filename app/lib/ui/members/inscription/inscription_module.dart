import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/core/di/injection.dart';
import 'package:judoseclin/ui/members/inscription/view/inscription_page.dart';
import 'package:judoseclin/ui/members/login/user_bloc.dart';
import 'package:judoseclin/ui/ui_module.dart';

import '../interactor/users_interactor.dart';

@singleton
class InscriptionModule implements UIModule {
  final AppRouter _appRouter;
  final UsersInteractor _usersInteractor; // Injecté via le constructeur

  InscriptionModule(this._appRouter, this._usersInteractor);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/inscription',
        pageBuilder: (context, state) {
          return MaterialPage(child: _buildLoginPage());
        },
      ),
    ];
  }

  Widget _buildLoginPage() {
    return BlocProvider<UserBloc>(
      create:
          (_) => UserBloc(
            getIt<UsersInteractor>(),
          ), // Utilisation correcte de UsersInteractor injecté
      child: InscriptionPage(usersInteractor: _usersInteractor),
    );
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }
}
