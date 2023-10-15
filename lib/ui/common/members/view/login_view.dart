import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/home_button.dart';

import '../../../../custom_textfield.dart';
import '../../../../image_fond_ecran.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
        // Ajouter d'autres réactions pour différents états si nécessaire
      },
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        double screenWidth = size.width;
        double titlefont = screenWidth / 13;

        return DecoratedBox(
          position: DecorationPosition.background,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageFondEcran.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
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
                const SizedBox(height: 40),
                CustomTextField(
                  labelText: 'E-mail',
                  controller: emailController,
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  labelText: 'Mot de passe',
                  controller: passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: screenWidth - 40,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(
                            LoginWithEmailPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[400]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    child: const SizedBox(
                      height: 50,
                      child: Center(child: Text("CONNEXION")),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/inscription');
                  },
                  child: Text(
                    "Ou créer un compte",
                    style: TextStyle(color: Colors.red[400]),
                  ),
                ),
                const SizedBox(height: 40), // You can adjust this for spacing
                const HomeButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
