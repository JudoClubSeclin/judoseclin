import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    Size size = MediaQuery.of(context).size;
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
                  height: 15,
                ),
                const Text(
                  "Attention pour les inscription metre le nom du judokas"
                  " et l'adresse email donné sur le formulaire",
                  style: TextStyle(color: Colors.red, fontSize: 11),
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  labelText: 'NOM',
                  controller: nomController,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  labelText: 'PRENOM',
                  controller: prenomController,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  labelText: 'Date de naissance (JJ/MM/AAAA)',
                  controller: dateNaissanceController,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  labelText: 'N° licence',
                  controller: numeroLicenceController,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  labelText: 'E-mail',
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  labelText: 'Mot de passe',
                  controller: passwordController,
                  obscureText: false,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    signUpToFirebase();
                    //  logique d'inscription
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
                        Text("JE M'INSCRIS"),
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
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: const Text("Connexion"),
                ),
              ],
            ),
          ),
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
