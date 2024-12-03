import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:judoseclin/core/router/router_config.dart';
import 'package:judoseclin/firebase_options.dart';
import 'package:judoseclin/injection.dart';
import 'package:judoseclin/theme.dart';



FirebaseAuth auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

void main() {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform
  );

  configureDependencies();

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
