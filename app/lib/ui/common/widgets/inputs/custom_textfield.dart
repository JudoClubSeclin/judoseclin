import 'package:flutter/material.dart';

import '../../../../theme.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final ValueChanged<String>? onChanged;  // <-- Ajouté

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.onChanged,  // <-- Ajouté
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = screenWidth > 600 ? screenWidth / 600 : 1;

    final borderColor = theme.colorScheme.primary;

    double maxWidth = 400.0;

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
            onChanged: onChanged,  // <-- Ici on transmet le callback
            style: textStyleInput(context, labelText),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: textStyleInput(context, labelText),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: borderColor,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 3 * scaleFactor,
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
