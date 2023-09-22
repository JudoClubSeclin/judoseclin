import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/firebase_options.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'landing.dart';

// coverage:ignore-start
void main() {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value){
    runApp( const Landing());
  });

}
// coverage:ignore-end
