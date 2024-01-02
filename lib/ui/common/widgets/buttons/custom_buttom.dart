import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculez la largeur souhaitée en fonction de la largeur de l'écran.
    double buttonWidth = screenWidth * 0.8;
    if (screenWidth > 800) {
      buttonWidth = 400.0; // Comme pour le CustomTextField
    }

    return Center(
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 30)),
            backgroundColor: MaterialStateProperty.all(Colors.red[400]),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
