import 'package:flutter/material.dart';
import 'package:judoseclin/main.dart';
import 'package:judoseclin/ui/common/landing_page_account/user_info.dart';

class LandingAccount extends StatelessWidget {
  const LandingAccount({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double? titlefont = size.width / 10;
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bonjour",
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
            SizedBox(
              height: 150,
              child: UserInfo(),
            )
          ],
        ),
      ),
    );
  }
}
