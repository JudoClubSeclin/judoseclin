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
    double screenWidth = MediaQuery.sizeOf(context).width;
    double scaleFactor = screenWidth > 600 ? screenWidth / 600 : 1;

    // Largeur maximale pour le champ de texte sur les grands écrans.
    double maxWidth = 400.0;

    // Calculez la largeur souhaitée en fonction de la largeur de l'écran.
    double textFieldWidth = screenWidth * 0.8;
    if (screenWidth > 800) {
      // 800 est un point de rupture arbitraire, vous pouvez l'ajuster.
      textFieldWidth = maxWidth;
    }

    return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: textFieldWidth,
            decoration: BoxDecoration(
              color:
                  Colors.transparent, // Pour s'assurer qu'il n'y a pas de fond
              border: Border.all(
                  color: Colors
                      .transparent), // Pour s'assurer qu'il n'y a pas de bordure
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(
                  fontSize: 12 *
                      scaleFactor), // Augmenter la taille de la police du texte saisi
              decoration: InputDecoration(
                labelText: labelText,
                labelStyle: TextStyle(
                  color: borderColor,
                  fontSize: 10 *
                      scaleFactor, // Augmenter la taille de la police de l'étiquette
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: borderColor,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 8 * scaleFactor,
                    horizontal: 10 *
                        scaleFactor), // Ajuster le padding selon le facteur d'échelle
              ),
              obscureText: obscureText,
            ),
          ),
        ));
  }
}
