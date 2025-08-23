import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:judoseclin/core/router/router_config.dart';
import 'package:judoseclin/firebase_options.dart';
import 'package:judoseclin/theme.dart';
import 'package:provider/provider.dart';

import 'core/di/injection.dart';
import 'core/utils/emojis.dart';
import 'core/utils/function_admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EmojiUtils.preloadEmojis();

  configureDependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FunctionAdminService()),
        // Ajoute d'autres providers ici si nécessaire
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouterConfig = GetIt.I<AppRouterConfig>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Judo club Seclin',
      theme: theme,
      routerConfig: appRouterConfig.router,
    );
  }
}
