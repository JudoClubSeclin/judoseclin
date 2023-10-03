import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.red[400] ?? Colors.transparent;

    // 1. Utilisez MediaQuery pour obtenir la largeur de l'écran
    double screenWidth = MediaQuery.of(context).size.width;

    // 2. Définissez un facteur d'échelle basé sur cette largeur
    double scaleFactor = screenWidth > 600 ? screenWidth / 600 : 1;

    return TextField(
      controller: controller,
      style: TextStyle(
          fontSize: 18 *
              scaleFactor), // Augmenter la taille de la police du texte saisi
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: borderColor,
          fontSize: 24 *
              scaleFactor, // Augmenter la taille de la police de l'étiquette
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
            vertical: 20 * scaleFactor,
            horizontal: 20 *
                scaleFactor), // Ajuster le padding selon le facteur d'échelle
      ),
      obscureText: obscureText,
    );
  }
}
