import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/core/di/api/auth_service.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:judoseclin/ui/adherents/adherents_bloc.dart';
import 'package:judoseclin/ui/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/adherents/view/add_adherents_view.dart';
import 'package:judoseclin/ui/ui_module.dart';

import '../../../core/di/injection.dart';

@singleton
class AddAdherentsModule implements UIModule {
  final AppRouter _appRouter;

  AddAdherentsModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
        path: '/admin/add/adherents',
        pageBuilder: (context, state) {
          return MaterialPage(
            child: _buildAccountPage(),
          );
        },
      ),
    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }

  Widget _buildAccountPage() {
    return BlocProvider<AdherentsBloc>(
      create: (context) {
        final interactor = getIt<AdherentsInteractor>();
        final auth = getIt<AuthService>();
        final firestoreService = getIt<FirestoreService>();

        return AdherentsBloc(
          interactor,
          auth,
          firestoreService,
          adherentId: '', // Remplacez par une valeur valide si nécessaire
        );
      },
      child: AddAdherentsView(),
        // Assurez-vous que `AdherentsRepository` est correctement défini dans `getIt`

    );
  }
}