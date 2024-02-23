import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../members/login/bloc/user_bloc.dart';
import '../../../members/login/bloc/user_state.dart';

class ConnexionButton extends StatelessWidget {
  const ConnexionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double buttonSize = screenWidth < 600
            ? 10.0
            : 50.0; // Ajustez la taille du bouton en fonction de la largeur de l'écran

        return Align(
          alignment: Alignment.topRight,
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red[400],
            ),
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                onPressed: () {
                  final userBloc = BlocProvider.of<UserBloc>(context);
                  final state = userBloc.state;

                  if (state is UserDataLoadedState) {
                    // L'utilisateur est connecté, redirigez-le vers la page de compte
                    context.go("/account");
                  } else {
                    // L'utilisateur n'est pas connecté, redirigez-le vers la page de connexion
                    context.go("/account/login");
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
