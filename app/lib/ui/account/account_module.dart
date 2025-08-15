import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:judoseclin/ui/account/account_bloc.dart';
import 'package:judoseclin/ui/account/account_interactor.dart';
import 'package:judoseclin/ui/account/view/account_page.dart';
import 'package:judoseclin/ui/ui_module.dart';
import 'package:provider/provider.dart';
import '../../core/di/api/auth_service.dart';
import '../../core/di/injection.dart';

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
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() => {};

  /// Fournit AuthService et AccountBloc aux widgets enfants
  Widget wrapWithProviders(BuildContext context, Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<AuthService>()),
        BlocProvider<AccountBloc>(
          create: (context) {
            final authService = getIt<AuthService>();
            final firestoreService = getIt<FirestoreService>();
            final interactor = getIt<AccountInteractor>();

            // Utilisation du constructeur avec tous les paramètres nommés
            return AccountBloc(
              firestore: firestoreService,
              accountInteractor: interactor,
              auth: authService,
            );
          },
        ),
      ],
      child: child,
    );
  }
}
