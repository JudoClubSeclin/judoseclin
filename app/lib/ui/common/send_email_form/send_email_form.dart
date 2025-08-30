import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/adherents.dart';

class SendEmailForm extends StatefulWidget {
  final Adherents adherent;

  const SendEmailForm({
    super.key,
    required this.adherent,
  });

  @override
  State<SendEmailForm> createState() => _SendEmailFormState();
}

class _SendEmailFormState extends State<SendEmailForm> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSending = false;

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSending = true);

    final subject = _subjectController.text;
    final message = _messageController.text;
    final email = widget.adherent.email;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email non renseigné")),
      );
      setState(() => _isSending = false);
      return;
    }

    try {
      final callable = FirebaseFunctions.instance.httpsCallable('sendEmail');
      final result = await callable.call(<String, dynamic>{
        'to': email,
        'subject': subject,
        'text': message,
      });

      if (result.data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email envoyé ✅")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur: ${e.toString()}")),
      );
    } finally {
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Envoyer un email"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Destinataire : ${widget.adherent.email}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        labelText: "Sujet",
                        labelStyle: const TextStyle(color: Colors.black87),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.subject),
                      ),
                      style: const TextStyle(color: Colors.black),
                      validator: (value) =>
                      value == null || value.isEmpty ? "Sujet obligatoire" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _messageController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        labelText: "Message",
                        alignLabelWithHint: true,
                        labelStyle: const TextStyle(color: Colors.black87),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.message),
                      ),
                      style: const TextStyle(color: Colors.black),
                      validator: (value) =>
                      value == null || value.isEmpty ? "Message obligatoire" : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _isSending ? null : _sendEmail,
                      icon: _isSending
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Icon(Icons.send),
                      label: Text(
                        _isSending ? "Envoi..." : "Envoyer",
                        style: const TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
