import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/ui/common/widgets/buttons/home_button.dart';

import '../../../theme/theme.dart';
import '../../../widgets/buttons/custom_buttom.dart';
import '../../../widgets/images/image_fond_ecran.dart';
import '../../../widgets/inputs/custom_textfield.dart';
import '../bloc/inscription_bloc.dart';
import '../bloc/inscription_event.dart';
import '../bloc/inscription_state.dart';

class InscriptionView extends StatelessWidget {
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final dateNaissanceController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  InscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InscriptionBloc, InscriptionState>(
      builder: (context, state) {
        if (state is SignUpLoadingState) {
          return const SizedBox(
              width: 60, height: 60, child: CircularProgressIndicator());
        } else if (state is SignUpErrorState) {
          return Text(state.error);
        } else {
          return _buildForm(context);
        }
      },
    );
  }

  Widget _buildForm(BuildContext context) {
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
                "Inscription",
                style: titleStyle(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomTextField(labelText: 'NOM', controller: nomController),
              const SizedBox(height: 10),
              CustomTextField(
                  labelText: 'PRENOM', controller: prenomController),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: 'Date de naissance (JJ/MM/AAAA)',
                controller: dateNaissanceController,
              ),
              const SizedBox(height: 10),
              CustomTextField(labelText: 'E-mail', controller: emailController),
              const SizedBox(height: 10),
              CustomTextField(
                labelText: 'Mot de passe',
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 10),
              CustomButton(
                onPressed: () {
                  context.read<InscriptionBloc>().add(
                        SignUpEvent(
                            nom: nomController.text.trim(),
                            prenom: prenomController.text.trim(),
                            dateNaissance: dateNaissanceController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            navigateToAccount: () =>
                                GoRouter.of(context).go('/account')),
                      );
                },
                label: "S'inscrire",
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                  onPressed: () => context.go('/login'),
                  child: Text(
                    "Connexion",
                    style: TextStyle(color: Colors.red[400]),
                    textAlign: TextAlign.center,
                  )),
            ],
          )),
    );
  }
}
