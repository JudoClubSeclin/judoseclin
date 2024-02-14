import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/ui/common/widgets/buttons/home_button.dart';

import '../../../common/theme/theme.dart';
import '../../../common/widgets/buttons/custom_buttom.dart';
import '../../../common/widgets/images/image_fond_ecran.dart';
import '../../../common/widgets/inputs/custom_textfield.dart';
import '../bloc/inscription_bloc.dart';
import '../bloc/inscription_event.dart';
import '../bloc/inscription_state.dart';

class InscriptionView extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dateOfBirthController = TextEditingController();
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomTextField(
                    labelText: 'NOM', controller: firstNameController),
                const SizedBox(width: 40),
                CustomTextField(
                    labelText: 'PRENOM', controller: lastNameController),
              ]),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    labelText: 'Date de naissance (JJ/MM/AAAA)',
                    controller: dateOfBirthController,
                  ),
                  const SizedBox(width: 40),
                  CustomTextField(
                      labelText: 'E-mail', controller: emailController),
                ],
              ),
              const SizedBox(height: 25),
              CustomTextField(
                labelText: 'Mot de passe',
                controller: passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 25),
              CustomButton(
                onPressed: () async {
                  try {
                    String firstNameInput = firstNameController.text.trim();
                    DateTime parseDate = DateFormat('dd/MM/yyyy')
                        .parse(dateOfBirthController.text.trim());
                    debugPrint('valeur de firstName $firstNameInput');

                    context.read<InscriptionBloc>().add(
                          InscriptionSignUpEvent(
                              id: '',
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              dateOfBirth: parseDate,
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              navigateToAccount: () =>
                                  GoRouter.of(context).go('/account')),
                        );
                  } catch (error) {
                    debugPrint('Erreur données non transmise: $error');
                  }
                },
                label: "S'inscrire",
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                  onPressed: () => context.go('/account/login'),
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
