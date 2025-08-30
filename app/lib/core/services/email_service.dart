import 'package:cloud_functions/cloud_functions.dart';

final functions = FirebaseFunctions.instance;

Future<void> sendEmail({
  required String to,
  required String subject,
  required String text,
  String? lien, // optionnel
}) async {
  final callable = functions.httpsCallable('sendEmail');
  await callable.call({
    'to': to,
    'subject': subject,
    'text': text,
    'lien': lien ?? "",
  });
}
