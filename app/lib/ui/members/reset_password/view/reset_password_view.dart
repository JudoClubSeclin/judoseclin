import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/ui/common/widgets/buttons/custom_buttom.dart';
import 'package:judoseclin/ui/common/widgets/inputs/custom_textfield.dart';
import 'package:judoseclin/ui/members/reset_password/reset_password_bloc.dart';
import 'package:judoseclin/ui/members/reset_password/reset_password_state.dart';

import '../../../../theme.dart';
import '../../../common/widgets/images/image_fond_ecran.dart';
import '../reset_password_event.dart';

class ResetPasswordView extends StatelessWidget {
  final emailController = TextEditingController();

  ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Lien de réinitialisation envoyé!")),
          );
          // Redirection vers la page de connexion après l'envoi réussi
          context.go('/account/login');
        } else if (state is ResetPasswordFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        return DecoratedBox(
          position: DecorationPosition.background,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageFondEcran.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Réinitialisation du mot de passe",
                  style: titleStyleMedium(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 80),
                CustomTextField(
                  labelText: 'E-mail',
                  controller: emailController,
                ),
                const SizedBox(height: 80),
                CustomButton(
                  onPressed: () {
                    BlocProvider.of<ResetPasswordBloc>(
                      context,
                    ).add(ResetPasswordRequested(email: emailController.text));
                  },
                  label: 'Envoyé',
                ),
                const SizedBox(height: 80),
                TextButton(
                  onPressed: () => context.go('/login'),
                  child: Text(
                    "Connexion",
                    style: TextStyle(color: Colors.red[400]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
