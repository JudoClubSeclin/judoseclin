import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/account/account_bloc.dart';
import 'package:judoseclin/ui/account/account_interactor.dart';
import 'package:judoseclin/ui/account/view/account_page.dart';
import 'package:judoseclin/ui/members/interactor/users_interactor.dart';
import 'package:judoseclin/ui/ui_module.dart';
import 'package:provider/provider.dart';

import '../../core/di/api/auth_service.dart';
import '../../domain/entities/setup_entity_module.dart';
import '../members/login/user_bloc.dart';
import '../members/login/view/login_view.dart';

@singleton
class AccountModule implements UIModule {
  final AppRouter _appRouter;

  AccountModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/account',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: wrapWithProviders(context, const AccountPage()),
          );
        },
      )
    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }

  /// Implémente la méthode wrapWithProviders pour éviter la duplication
  Widget wrapWithProviders(BuildContext context, Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<AuthService>()),
        BlocProvider<AccountBloc>(
          create: (context) {
            final userId = getIt<FirebaseAuth>().currentUser?.uid;
            final interactor = getIt<AccountInteractor>();
            return AccountBloc(userId: userId ?? '', accountInteractor: interactor);
          },
        ),
      ],
      child: child,
    );
  }
}
