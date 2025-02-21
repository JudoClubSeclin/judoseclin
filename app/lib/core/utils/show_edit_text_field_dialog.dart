import'package:flutter/material.dart';
import 'package:judoseclin/theme.dart';

Future<String?> myShowEditTextFieldDialog({
  required BuildContext context,
  required String initialValue,
  required String labelText,
}) async {
  TextEditingController controller = TextEditingController(text: initialValue);

  return showDialog<String>(
    context: context,
    builder: (context) {
      return Theme(
        data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(
              backgroundColor: Colors.white,
            ),
          textTheme: Theme
              .of(context)
              .textTheme
              .apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
        ),
        child: AlertDialog(
          title: Text(labelText, style: textStyleText(context)),
          content: TextField(
            controller: controller,
            style: textStyleText(context),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:  Text(
                  "Annuler", style: textStyleText(context).copyWith(color: theme.colorScheme.primary)),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child:  Text("OK", style: textStyleText(context).copyWith(color: theme.colorScheme.primary)),
            ),
          ],
        ),
      );
    },
  );
}