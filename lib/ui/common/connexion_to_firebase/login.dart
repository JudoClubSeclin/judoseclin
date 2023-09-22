import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/connexion_to_firebase/inscription.dart';

import '../../../custom_textfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double? titlefont = size.width / 9;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 10),
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
                  height: 70,
                ),
                CustomTextField(
                  labelText: 'E-mail',
                  controller: emailController,
                ),
                const SizedBox(height: 70),
                CustomTextField(
                  labelText: 'Mot de passe',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 70),
                ElevatedButton(
                  onPressed: () {
                    // Gérez l'authentification ici en utilisant les contrôleurs
                    String email = emailController.text;
                    String password = passwordController.text;
                    // Ajoutez votre logique de connexion ici
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        builder: (context) => const Inscription(),
                      ),
                    );
                  },
                  child: const Text("Ou créer un compte"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
