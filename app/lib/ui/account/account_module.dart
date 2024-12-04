

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/account/bloc/account_bloc.dart';
import 'package:judoseclin/ui/account/interactor/account_interactor.dart';
import 'package:judoseclin/ui/account/view/account_page.dart';
import 'package:judoseclin/ui/ui_module.dart';

import '../../data/repository/user_repository/user_auth_repository.dart';
import '../../data/repository/user_repository/user_data_repository.dart';
import '../../domain/entities/entity_module.dart';
import '../members/login/bloc/user_bloc.dart';
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
                child: _buildAccountPage(),
            );
      }
      )
    ];
    }
    @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
    }

  Widget _buildAccountPage() {
    final String? userId = getIt<FirebaseAuth>().currentUser?.uid;

    if (userId != null) {
      return BlocProvider<AccountBloc>(
        create: (context) {
          final userRepository = getIt<UserAuthRepository>();
          final interactor = AccountInteractor(
            getIt<UserDataRepository>(),
            userId,
          );
          return AccountBloc(accountInteractor: interactor, userId: userId);
        },
        child: const AccountPage(),
      );
    } else {
      return BlocProvider<UserBloc>(
        create: (context) => getIt<UserBloc>(),
        child:  LoginView(),
      );
    }
    // Retour par défaut si toutes les branches échouent (utile pour les cas d'erreur)
    return const SizedBox.shrink();
  }


}