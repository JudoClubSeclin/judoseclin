import 'package:flutter/material.dart';
import 'package:judoseclin/main.dart';
import 'package:judoseclin/ui/common/landing_page_account/user_info.dart';

class LandingAccount extends StatelessWidget {
  const LandingAccount({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Modifiez cette ligne
    double titlefont = size.width / 10; // Retirez le "?"
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0), // Hauteur de l'AppBar
          child: AppBar(
            backgroundColor: Colors.red[400],
            title: const Text('Mon compte'),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.logout), // Icône à droite de l'AppBar
                  onPressed: () {
                    auth.signOut();
                  }),
            ],
          ),
        ),
        body: ListView(
          // Modifiez cette ligne
          children: <Widget>[
            Center(
              child: Text(
                "Bienvenue ",
                style: TextStyle(
                  fontFamily: 'Hiromisake',
                  fontSize: titlefont,
                  color: Colors.black,
                  shadows: const [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 3.0,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height -
                  (titlefont + 56.0 + 20.0),
              child: const UserInfo(),
            ),
          ],
        ),
      ),
    );
  }
}
