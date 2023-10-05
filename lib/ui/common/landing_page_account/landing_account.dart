import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/landing_page_account/user_info.dart';

import '../../../appbar.dart';
import '../competition_info/view/screen/competitions_list_screen.dart';

class LandingAccount extends StatelessWidget {
  const LandingAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double titlefont = size.width / 10;

    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        actions: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const CompetitionsListScreen(),
              ));
            },
            child: Container(
              height: 56.0, // la hauteur de l'AppBar
              alignment: Alignment.center, // centrage du contenu
              child: const Text("Compétition"),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
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
          ),
          SizedBox(
            height: size.height - (titlefont + 56.0 + 20.0),
            child: const UserInfo(),
          ),
        ],
      ),
    );
  }
}
