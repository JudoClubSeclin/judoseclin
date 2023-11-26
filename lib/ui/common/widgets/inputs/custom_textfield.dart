import 'package:flutter/material.dart';

import '../../theme/theme.dart';

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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = screenWidth > 600 ? screenWidth / 600 : 1;

    final borderColor = Colors.red[400] ?? Colors.transparent;

    double maxWidth = 400.0;

    //calculez la largeur souhaitée en fonction de la taille de l'écran
    double textFieldWidth = screenWidth * 0.8;
    if (screenWidth > 800) {
      textFieldWidth = maxWidth;
    }

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: textFieldWidth,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.transparent),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 15 * scaleFactor,
            ),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: textStyleInput(context, labelText),
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
                horizontal: 10 * scaleFactor,
              ),
            ),
            obscureText: obscureText,
          ),
        ),
      ),
    );
  }
}
