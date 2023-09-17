import 'package:flutter/material.dart';

import 'login_page.dart';

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
        child: IconButton(
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigation vers la page de connexion
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  // Remplacez LoginPage par le nom de votre page de connexion
                  return const LoginPage();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

