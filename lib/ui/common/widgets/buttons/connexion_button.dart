import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConnexionButton extends StatelessWidget {
  const ConnexionButton({super.key});

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
                onPressed: () => context.go("/account/login"),
              ),
            ),
          ),
        );
      },
    );
  }
}
