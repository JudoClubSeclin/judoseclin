import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/ui/common/widgets/buttons/home_button.dart';

import '../../../../theme.dart';
import '../../../common/widgets/buttons/custom_buttom.dart';
import '../../../common/widgets/images/image_fond_ecran.dart';
import '../../../common/widgets/inputs/custom_textfield.dart';
import '../user_bloc.dart';
import '../user_event.dart';
import '../user_state.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showDialog(
            context: context,
<<<<<<< HEAD
            builder:
                (context) => AlertDialog(
                  title: const Text("Erreur de connexion"),
                  content: Text(state.error),
                  actions: [
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      child: const Text("OK"),
                    ),
                  ],
=======
            builder: (context) => AlertDialog(
              title:  Text("L'email est le mot de passe ne corresponde pas ",style: textStyleText(context),),
              content: Text(state.error),
              actions: [
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  child: const Text("OK"),
>>>>>>> refactoclean
                ),
          );
        }
        // Ajoutez d'autres réactions pour différents états si nécessaire
      },
      builder: (context, constraints) {
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
                const HomeButton(),
                Text(
                  "CONNEXION",
                  style: titleStyle(context),
                  textAlign: TextAlign.center,
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
                  child: CustomButton(
                    label: 'Connexion',
                    onPressed: () {
                      BlocProvider.of<UserBloc>(context).add(
                        LoginWithEmailPassword(
                          email: emailController.text,
                          password: passwordController.text,
                          navigateToAccount: () {
                            GoRouter.of(context).go('/account');
                          },
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => context.go('/inscription'),
                        child: Text(
                          "Créer un compte",
                          style: textStyleText(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    /* Expanded(
                      child: TextButton(
                        onPressed: () => context.go('/reset_password'),
                        child: Text(
                          "Mot de passe oublié ?",
                          style: textStyleText(context),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),*/
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
