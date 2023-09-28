import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/landing_page_account/landing_account.dart';

import 'landing.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Landing();
    } else {
      return const LandingAccount();
    }
  }
}
