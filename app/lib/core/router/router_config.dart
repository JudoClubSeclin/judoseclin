import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/ui/account/account_module.dart';
import 'package:judoseclin/ui/landing/landing_module.dart';

import '../../domain/entities/entity_module.dart';

@singleton
class AppRouterConfig {
  GoRouter get router => GoRouter(
      routes: [
        ...getIt<LandingModule>().getRoutes(),
        ...getIt<AccountModule>().getRoutes()
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