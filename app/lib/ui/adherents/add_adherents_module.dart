import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/repository/adherents_repository_impl.dart';
import 'package:judoseclin/ui/adherents/adherents_bloc.dart';
import 'package:judoseclin/ui/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/adherents/view/add_adherents_view.dart';

import 'package:judoseclin/ui/competition/list_competition/competition_bloc.dart';
import 'package:judoseclin/ui/competition/list_competition/competition_interactor.dart';
import 'package:judoseclin/ui/competition/list_competition/view/competition_list_view.dart';
import 'package:judoseclin/ui/ui_module.dart';

import '../../../core/di/injection.dart';
import '../../data/repository/adherents_repository.dart';
import '../../domain/usecases/fetch_adherents_data_usecase.dart';



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
          })
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

          return AdherentsBloc(interactor, adherentId: '');
        },
        child:  AddAdherentsView(),
      );

    }
  }

