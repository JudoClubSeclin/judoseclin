import 'package:flutter/material.dart';
import 'package:judoseclin/size_extensions.dart';
import 'package:judoseclin/ui/common/connexion_to_firebase/login.dart';

import '../../../custom_textfield.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  _Inscription createState() => _Inscription();
}

class _Inscription extends State<Inscription> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    SizeOrientation orientation = size.orientation();
    double? titlefont = size.width / 9;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 55, horizontal: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter, // Aligner le texte en haut
                child: Text(
                  "INSCRIPTION",
                  style: TextStyle(
                    fontFamily: 'Hiromisake',
                    fontSize: titlefont,
                    color: Colors.black,
                    shadows: const [
                      Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 3.0,
                          color: Colors.black),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 70),
              CustomTextField(
                labelText: 'NOM',
                controller: emailController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'PRENOM',
                controller: emailController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'Née le',
                controller: emailController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'N° licence',
                controller: emailController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                labelText: 'E-mail',
                controller: emailController,
              ),
              const SizedBox(height: 20),
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
                      Text("JE M'INSCRIE"),
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
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: Text("Connexion")),
            ],
          ),
        )),
      ),
    );
  }
}
