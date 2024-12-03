import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:judoseclin/core/router/router_config.dart';
import 'package:judoseclin/data/repository/repository_module.dart';
import 'package:judoseclin/firebase_options.dart';
import 'package:judoseclin/injection.dart';
import 'package:judoseclin/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureDependencies();
  setupDataModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouterConfig = GetIt.I<AppRouterConfig>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Le cocon.ssbe',
      theme: theme,
      routerConfig: appRouterConfig.router,
    );
  }
}
