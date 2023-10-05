import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/landing_page_account/landing_account.dart';

import 'landing.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user == null ? const Landing() : const LandingAccount();
        }
        return const CircularProgressIndicator(); // Affiche un indicateur de chargement pendant la vérification
      },
    );
  }
}
