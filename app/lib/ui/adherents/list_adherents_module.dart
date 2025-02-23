import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/adherents/adherents_bloc.dart';
import 'package:judoseclin/ui/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/adherents/view/list_adherents_view.dart';
import 'package:judoseclin/ui/ui_module.dart';

import '../../../core/di/injection.dart';
import '../../core/di/api/auth_service.dart';
import '../../core/di/api/firestore_service.dart';

@singleton
class ListAdherentsModule implements UIModule {
  final AppRouter _appRouter;

  ListAdherentsModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/admin/list/adherents',
        pageBuilder: (context, state) {
          return MaterialPage(child: _buildAccountPage());
        },
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }

  Widget _buildAccountPage() {
    final interactor = getIt<AdherentsInteractor>();
    final auth = getIt<AuthService>();
    final firestoreService = getIt<FirestoreService>();
    return BlocProvider<AdherentsBloc>(
      create: (context) {
        return AdherentsBloc(
          interactor,
          auth,
          firestoreService,
          adherentId: '',
        );
      },
      child: ListAdherentsView(interactor: interactor),
    );
  }
}
