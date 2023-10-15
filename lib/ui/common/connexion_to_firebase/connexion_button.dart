import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConnexionButton extends StatelessWidget {
  const ConnexionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red[400],
        ),
        child: Material(
          color: Colors
              .transparent, // Pour éviter d'ajouter un fond supplémentaire
          child: IconButton(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () => context.go("/login"),
          ),
        ),
      ),
    );
  }
}
