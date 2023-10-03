import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/home_button.dart';
import 'package:judoseclin/main.dart';
import 'package:judoseclin/ui/common/connexion_to_firebase/inscription.dart';

import '../../../custom_textfield.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double screenWidth = MediaQuery.sizeOf(context).width;
    double scaleFactor = screenWidth < 600 ? 1 : (600 / screenWidth);
    double? titlefont = size.width / 9;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 55, horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      "CONNEXION",
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
                    const SizedBox(
                      height: 40,
                    ),
                    Transform.scale(
                      scale: scaleFactor,
                      child: CustomTextField(
                        labelText: 'E-mail',
                        controller: emailController,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Transform.scale(
                      scale: scaleFactor,
                      child: CustomTextField(
                        labelText: 'Mot de passe',
                        controller: passwordController,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        loginToFirebase();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[400]),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      child: const SizedBox(
                        height: 50,
                        width: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("CONNEXION"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Inscription(),
                          ),
                        );
                      },
                      child: Text(
                        "Ou créer un compte",
                        style: TextStyle(
                          color: Colors.red[400],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const HomeButton(), // Ce bouton sera superposé en haut à droite
          ],
        ),
      ),
    );
  }

  void loginToFirebase() {
    try {
      auth
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) {
        if (kDebugMode) {
          print(value.toString());
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
