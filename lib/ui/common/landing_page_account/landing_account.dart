import 'package:flutter/material.dart';
import 'package:judoseclin/main.dart';

class LandingAccount extends StatelessWidget {
  const LandingAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red[400],
            title: const Text('Mon compte'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Bonjour"),
              ElevatedButton(
                onPressed: () {
                  auth.signOut();
                },
                child: const Text('Déconnexion'),
              )
            ],
          )),
    );
  }
}
