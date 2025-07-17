import 'package:flutter/material.dart';

import '../../../../theme.dart';

class CustomTextArea extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;

  const CustomTextArea({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double scaleFactor = screenWidth > 600 ? screenWidth / 600 : 1;

    final borderColor = theme.colorScheme.primary;

    double maxWidth = 400.0;

    double textAreaWidth = screenWidth * 0.8;
    if (screenWidth > 800) {
      textAreaWidth = maxWidth;
    }

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: textAreaWidth,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.transparent),
          ),
          child: TextField(
            controller: controller,
            style: textStyleInput(context, labelText),
            maxLines: 6, // Définit la hauteur du textarea (6 lignes ici)
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: textStyleInput(context, labelText),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: borderColor),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10 * scaleFactor,
                horizontal: 10 * scaleFactor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
