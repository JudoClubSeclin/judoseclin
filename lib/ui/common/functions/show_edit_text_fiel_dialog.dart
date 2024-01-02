import 'package:flutter/material.dart';

Future<String?> showEditTextFieldDialog({
  required BuildContext context,
  required String initialValue,
  required String labelText,
}) async {
  TextEditingController controller = TextEditingController(text: initialValue);

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(labelText),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: labelText),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Enregistrer'),
          ),
        ],
      );
    },
  );
}
