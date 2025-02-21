import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/ui/common/widgets/buttons/home_button.dart';

import '../../../../theme.dart';
import '../../../common/widgets/buttons/custom_buttom.dart';
import '../../../common/widgets/images/image_fond_ecran.dart';
import '../../../common/widgets/inputs/custom_textfield.dart';
import '../inscription_bloc.dart';
import '../inscription_event.dart';
import '../inscription_state.dart';

class InscriptionView extends StatelessWidget {
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
                style: titleStyleMedium(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 40.0,
                  runSpacing: 20.0, children: [

                  const SizedBox(width: 40),
                  CustomTextField(
                      labelText: "E-mail : Celui  donner au club ", controller: emailController),

              const SizedBox(height: 25),
              CustomTextField(
                labelText: 'Mot de passe',
                controller: passwordController,
                obscureText: true,
              ),
            ],
          ),
              const SizedBox(height: 25),
              CustomButton(
                onPressed: () async {
                  try {

                    context.read<InscriptionBloc>().add(
                          InscriptionSignUpEvent(
                              id: '',
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
                  onPressed: () => context.go('/login'),
                  child: Text(
                    "Connexion",
                    style: textStyleText(context),
                    textAlign: TextAlign.center,
                  )),
            ],
          )),
    );
  }
}
