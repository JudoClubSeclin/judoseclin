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
    final borderColor = Colors.red[400] ?? Colors.transparent; // Utilisez la couleur par défaut si elle est nulle

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,

        labelStyle: TextStyle(
          color: borderColor, // Couleur du label
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: borderColor, // Bord du TextField
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: BorderSide(
            color: borderColor, // Bord du TextField lorsqu'il est en focus
          ),
        ),
        // Ajoutez d'autres styles et configurations ici
      ),
      obscureText: obscureText,
    );
  }
}
