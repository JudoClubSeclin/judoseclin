import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:judoseclin/ui/news/add_news_view.dart';
import 'package:judoseclin/ui/news/news_bloc.dart';
import 'package:judoseclin/ui/ui_module.dart';

import '../../core/di/injection.dart';
import 'news_interactor.dart';

@singleton
class AddNewsModule implements UIModule {
  final AppRouter _appRouter;

  AddNewsModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }
  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
          path: '/admin/add/news',
      pageBuilder: (context, state) {
            return MaterialPage(child: _buildAccountPage());
      }
      )
    ];
  }

  @override
  Map<String, WidgetBuilder> getShareWidgets() {
    return {};
  }

  Widget _buildAccountPage() {
    return BlocProvider<NewsBloc>(
      create: (context) {
        final newsInteractor = getIt<NewsInteractor>();
        final _service = getIt<FirestoreService>();

        return NewsBloc(_service, newsInteractor, newsId: '');
      },
      child: AddNewsView(),
    );
  }
}