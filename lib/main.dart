import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:judoseclin/firebase_options.dart';
import 'package:judoseclin/ui/common/landing_page_account/landing_account.dart';

import 'landing.dart';

FirebaseAuth auth = FirebaseAuth.instance;

void main() {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          print('Utilisateur non connecté');
        }
        runApp(const Landing());
      } else {
        if (kDebugMode) {
          print('Utilisateur connecté: ' + user.email!);
        }
        runApp(const LandingAccount());
      }
    });
  });
}
