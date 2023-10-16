import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/ui/common/widgets/buttons/home_button.dart';

import '../../../theme/theme.dart';
import '../../../widgets/buttons/custom_buttom.dart';
import '../../../widgets/images/image_fond_ecran.dart';
import '../../../widgets/inputs/custom_textfield.dart';
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
        Size size = MediaQuery.sizeOf(context);
        double screenWidth = size.width;

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
                  width: screenWidth - 40,
                  child: CustomButton(
                    label: 'Connexion',
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context).add(
                        LoginWithEmailPassword(
                            email: emailController.text,
                            password: passwordController.text,
                            navigateToAccount: () =>
                                GoRouter.of(context).go('/account')),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 22),
                TextButton(
                  onPressed: () => context.go('/inscription'),
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
