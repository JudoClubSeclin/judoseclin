import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/injection.dart';
import '../../../members/login/user_bloc.dart';
import '../../../members/login/user_state.dart';

class ConnexionButton extends StatelessWidget {
  const ConnexionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double buttonSize = screenWidth < 600 ? 10.0 : 50.0;

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
                  // Récupère le UserBloc depuis GetIt
                  final userBloc = getIt<UserBloc>(); // GetIt récupère l'instance du UserBloc

                  final state = userBloc.state;

                  if (state is UserDataLoadedState) {
                    debugPrint('User is connected, navigate to /account');
                    context.go("/account"); // L'utilisateur est connecté, redirige vers /account
                  } else {
                    debugPrint('User is not connected, navigate to /login');
                    context.go("/login"); // L'utilisateur n'est pas connecté, redirige vers /login
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

