import 'package:flutter/material.dart';
import 'package:judoseclin/landing.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

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
            Icons.home,
            color: Colors.white,
          ),
          onPressed: () {
            // Navigation vers la page de connexion
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return const Landing();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
