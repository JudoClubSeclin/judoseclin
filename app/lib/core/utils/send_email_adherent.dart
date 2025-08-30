import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:judoseclin/domain/entities/adherents.dart';
import 'dart:convert';

class SendEmailAdherent extends StatefulWidget {
  final Adherents adherent;

  const SendEmailAdherent({super.key, required this.adherent});

  @override
  State<SendEmailAdherent> createState() => _SendEmailAdherentState();
}

class _SendEmailAdherentState extends State<SendEmailAdherent> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  bool _isSending = false;

  Future<void> _sendEmail() async {
    final toEmail = widget.adherent.email ?? "";
    final subject = _subjectController.text.trim();
    final body = _messageController.text.trim();

    debugPrint("📨 Tentative d'envoi d'email...");
    debugPrint("Destinataire: $toEmail");
    debugPrint("Sujet: $subject");
    debugPrint("Message: $body");

    if (toEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Aucun email disponible pour cet adhérent")),
      );
      return;
    }

    if (subject.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Sujet et message obligatoires")),
      );
      return;
    }

    setState(() {
      _isSending = true;
    });

    try {
      // 🔑 Remplace par tes vraies clés EmailJS
      const serviceId = "service_xxxxxxx";
      const templateId = "template_xxxxxxx";
      const userId = "user_xxxxxxx";

      final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
      final response = await http.post(
        url,
        headers: {
          "origin": "http://localhost",
          "Content-Type": "application/json",
        },
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "template_params": {
            "to_email": toEmail,
            "subject": subject,
            "message": body,
          },
        }),
      );

      if (response.statusCode == 200) {
        debugPrint("✅ Email envoyé avec succès !");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Email envoyé avec succès")),
        );
      } else {
        debugPrint("❌ Erreur EmailJS: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Erreur envoi: ${response.body}")),
        );
      }
    } catch (e) {
      debugPrint("❌ Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Erreur: $e")),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final adherent = widget.adherent;

    return Scaffold(
      appBar: AppBar(
        title: Text("Email à ${adherent.firstName}"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📧 Destinataire: ${adherent.email ?? "Non renseigné"}"),
            const SizedBox(height: 20),

            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: "Sujet",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _messageController,
              maxLines: 6,
              decoration: const InputDecoration(
                labelText: "Message",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: _isSending ? null : _sendEmail,
                icon: _isSending
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Icon(Icons.send),
                label: Text(_isSending ? "Envoi en cours..." : "Envoyer"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
