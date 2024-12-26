import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/members/login/user_bloc.dart';
import 'package:judoseclin/ui/members/login/view/login_view.dart';
import 'package:judoseclin/ui/ui_module.dart';

import '../interactor/users_interactor.dart';

@singleton
class LoginModule implements UIModule {
  final AppRouter _appRouter;

  LoginModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: _buildLoginPage(),
          );
        },
      ),
    ];
  }

  Widget _buildLoginPage() {
    return BlocProvider<UserBloc>(
      create: (context) {
        // Assurez-vous que le nom du paramètre correspond au constructeur de UsersInteractor
        var interactor = UsersInteractor();
        return UserBloc(interactor, userId: '');
      },
      child: LoginView(),
    );
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }
}
