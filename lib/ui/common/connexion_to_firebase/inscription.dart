import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/home_button.dart';
import 'package:judoseclin/main.dart';
import 'package:judoseclin/ui/common/connexion_to_firebase/login.dart';

import '../../../custom_textfield.dart';
import '../../../image_fond_ecran.dart';
import '../landing_page_account/landing_account.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Inscription extends StatelessWidget {
  Inscription({Key? key}) : super(key: key);

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final dateNaissanceController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.sizeOf(context).width;
    double scaleFactor = screenWidth < 600 ? 1 : (600 / screenWidth);
    double? titlefont = size.width / 9;

    return Scaffold(
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageFondEcran.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
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
                      const SizedBox(height: 10),
                      const Text(
                        "Attention pour les inscriptions mettre le nom du judoka"
                        " et l'adresse email données sur le formulaire papier",
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
                          signUpToFirebase(context);
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
                      const SizedBox(height: 17),
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
      ),
    );
  }

  void signUpToFirebase(BuildContext context) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) async {
        if (kDebugMode) {
          print(value.user!.uid);
          await addUser(
            value.user!.uid,
            nomController.text.trim(),
            prenomController.text.trim(),
            dateNaissanceController.text.trim(),
            emailController.text.trim(),
          );
        }
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LandingAccount()));
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> addUser(String userID, String nom, String prenom,
      String datedenaissance, String email) {
    return firestore
        .collection('Users')
        .doc(userID)
        .set({
          'nom': nom,
          'prenom': prenom,
          'date de naissance': datedenaissance,
          'email': email
        })
        .then((value) => debugPrint('Utilisateur ajouté'))
        .catchError((error) => debugPrint('error:$error'));
  }
}
