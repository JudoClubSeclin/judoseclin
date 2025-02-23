import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/core/di/injection.dart';
import 'package:judoseclin/ui/members/reset_password/reset_password_bloc.dart';

import 'package:judoseclin/ui/members/reset_password/view/reset_password_view.dart';
import 'package:judoseclin/ui/ui_module.dart';

import '../interactor/users_interactor.dart';

@singleton
class ResetPasswordModule implements UIModule {
  final AppRouter _appRouter;

  ResetPasswordModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/reset_password',
        pageBuilder: (context, state) {
          return MaterialPage(child: _buildLoginPage());
        },
      ),
    ];
  }

  Widget _buildLoginPage() {
    return BlocProvider<ResetPasswordBloc>(
      create:
          (_) => ResetPasswordBloc(
            getIt<UsersInteractor>(),
          ), // Utilisation correcte de UsersInteractor injecté
      child: ResetPasswordView(),
    );
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }
}
