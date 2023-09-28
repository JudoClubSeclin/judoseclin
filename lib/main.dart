import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:judoseclin/firebase_options.dart';
import 'package:judoseclin/root.dart';

FirebaseAuth auth = FirebaseAuth.instance;

void main() {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Root(),
    ));
  });
}
