import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/landing_page_account/landing_account.dart';

import 'landing.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return user == null ? const Landing() : const LandingAccount();
  }
}
