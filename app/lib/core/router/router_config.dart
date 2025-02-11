import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/account/account_module.dart';
import 'package:judoseclin/ui/adherents/add_adherents_module.dart';
import 'package:judoseclin/ui/competition/list_competition/detail_competition_module.dart';
import 'package:judoseclin/ui/competition/list_competition/list_competition_module.dart';
import 'package:judoseclin/ui/landing/landing_module.dart';
import 'package:judoseclin/ui/members/inscription/inscription_module.dart';
import 'package:judoseclin/ui/members/login/login_module.dart';
import 'package:judoseclin/ui/members/reset_password/reset_password_module.dart';

import '../../domain/entities/entity_module.dart';

@singleton
class AppRouterConfig {
  GoRouter get router => GoRouter(
        routes: [
          ...getIt<LandingModule>().getRoutes(),
          ...getIt<AccountModule>().getRoutes(),
          ...getIt<LoginModule>().getRoutes(),
          ...getIt<InscriptionModule>().getRoutes(),
          ...getIt<ResetPasswordModule>().getRoutes(),
          ...getIt<ListCompetitionModule>().getRoutes(),
          ...getIt<CompetitionDetailModule>().getRoutes(),
          ...getIt<AddAdherentsModule>().getRoutes()
        ],
        errorBuilder: (context, state) => const ErrorPage(),
      );
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Page not found'),
      ),
    );
  }
}
