import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/home_button.dart'; // Assurez-vous d'importer le widget HomeButton.
import 'package:judoseclin/main.dart';
import 'package:judoseclin/ui/common/connexion_to_firebase/login.dart';

import '../../../custom_textfield.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Inscription extends StatelessWidget {
  Inscription({Key? key}) : super(key: key);

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final dateNaissanceController = TextEditingController();
  final numeroLicenceController = TextEditingController();
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
        padding: const EdgeInsets.all(13.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 55, horizontal: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
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
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Attention pour les inscription mettre le nom du judokas"
                      " et l'adresse email donné sur le formulaire",
                      style: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    Transform.scale(
                      scale: scaleFactor,
                      child: CustomTextField(
                        labelText: 'NOM',
                        controller: nomController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Transform.scale(
                      scale: scaleFactor,
                      child: CustomTextField(
                        labelText: 'PRENOM',
                        controller: prenomController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Transform.scale(
                      scale: scaleFactor,
                      child: CustomTextField(
                        labelText: 'Date de naissance (JJ/MM/AAAA)',
                        controller: dateNaissanceController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Transform.scale(
                      scale: scaleFactor,
                      child: CustomTextField(
                        labelText: 'N° licence',
                        controller: numeroLicenceController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Transform.scale(
                      scale: scaleFactor,
                      child: CustomTextField(
                        labelText: 'E-mail',
                        controller: emailController,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Transform.scale(
                      scale: scaleFactor,
                      child: CustomTextField(
                        labelText: 'Mot de passe',
                        controller: passwordController,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(height: 17),
                    ElevatedButton(
                      onPressed: () {
                        signUpToFirebase();
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
                            Text("JE M'INSCRIS"),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        "Connexion",
                        style: TextStyle(color: Colors.red[400]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 15,
              right: 15,
              child: HomeButton(),
            ),
          ],
        ),
      ),
    );
  }

  void signUpToFirebase() {
    try {
      auth
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) {
        if (kDebugMode) {
          print(value.user!.uid);
          addUser(
            value.user!.uid,
            nomController.text.trim(),
            prenomController.text.trim(),
            dateNaissanceController.text.trim(),
            numeroLicenceController.text.trim(),
            emailController.text.trim(),
          );
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> addUser(String userID, String nom, String prenom,
      String datedenaissance, String licence, String email) {
    return firestore
        .collection('Users')
        .doc(userID)
        .set({
          'nom': nom,
          'prenom': prenom,
          'date de naissance': datedenaissance,
          'licence': licence,
          'email': email
        })
        .then((value) => print('Utilisateur ajouté'))
        .catchError((error) => print('Erreur: $error'));
  }
}
