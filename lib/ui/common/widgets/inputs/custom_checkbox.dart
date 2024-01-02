import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final String labelText;
  final TextEditingController controller; // Ajout du contrôleur
  final ValueNotifier<bool> isCheckedNotifier;

  const CustomCheckBox({
    super.key,
    required this.labelText,
    required this.controller,
    required this.isCheckedNotifier,
  });

  @override
  CustomCheckBoxState createState() => CustomCheckBoxState();
}

class CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Fond transparent
      child: InkWell(
        onTap: () {
          setState(() {
            widget.isCheckedNotifier.value = !widget.isCheckedNotifier.value;
          });
        },
        child: IntrinsicWidth(
          child: CheckboxListTile(
            title: Text(widget.labelText),
            controlAffinity: ListTileControlAffinity.leading,
            value: widget.isCheckedNotifier.value,
            onChanged: (bool? value) {
              setState(() {
                widget.isCheckedNotifier.value = value ?? false;
              });
            },
            tileColor: Colors.transparent, // Fond transparent
          ),
        ),
      ),
    );
  }
}
