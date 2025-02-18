import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:flutter/material.dart';
import '../../ui/adherents/interactor/adherents_interactor.dart';
import 'emojis.dart';

Future<void> generateAndPrintPdf(String adherentId, AdherentsInteractor adherentsInteractor) async {


  if (adherentId.isEmpty) {
    debugPrint("Erreur : L'ID de l'adhérent est vide !");
    return;
  }

  try {
    debugPrint("Fetching adherent data...");
    final adherent = await adherentsInteractor.getAdherentsById(adherentId);

    if (adherent == null) {
      debugPrint("Erreur : Aucun adhérent trouvé avec cet ID !");
      return;
    }

    final pdf = pw.Document();

    // Chargement des polices
    final regularFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
    final boldFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf"));
    // Chargement d'une police de symboles
    final symbolFont = pw.Font.ttf(await rootBundle.load("assets/fonts/NotoEmoji-Regular.ttf"));


    // Formatage de la date de naissance
    String formattedDateOfBirth = "Non spécifiée";
    if (adherent.dateOfBirth != null) {
      if (adherent.dateOfBirth is DateTime) {
        formattedDateOfBirth = DateFormat('dd/MM/yyyy').format(adherent.dateOfBirth!);
      } else if (adherent.dateOfBirth is String) {
        formattedDateOfBirth = adherent.dateOfBirth as String;
      }
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(
                child: pw.Text(
                  "Fiche Adhérent",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              _buildRowWithIcon("personne" , "Nom :", adherent.firstName ?? "Non spécifié", regularFont),
              _buildRowWithIcon("personne", "Prénom :", adherent.lastName ?? "Non spécifié", regularFont),
              _buildRowWithIcon("tuteur", "Tuteur legal :", adherent.tutor ?? "Non spécifié", regularFont),
              _buildRowWithIcon("calandrier", "Date de naissance :", adherent.formattedDateOfBirth ?? "Non spécifié", regularFont),
              _buildRowWithIcon("adresse", "Adresse :", adherent.address ?? "Non spécifié", regularFont),
              _buildRowWithIcon("email", "Email :", adherent.email ?? "Non spécifié", regularFont),
              _buildRowWithIcon("phone", "Téléphone :", adherent.phone ?? "Non spécifié", regularFont),
              _buildRowWithIcon("ceinture", "Ceinture :", adherent.belt ?? "Non spécifié", regularFont),
              _buildRowWithIcon("discipline", "Discipline :", adherent.discipline ?? "Non spécifié", regularFont),
              _buildRowWithIcon("categorie", "Catégorie :", adherent.category ?? "Non spécifié", regularFont),
              _buildRowWithIcon("certificate", "Certificat medical :", adherent.medicalCertificate ?? "Non spécifié", regularFont),
              _buildRowWithIcon("licence", "Licence :", adherent.licence ?? "Non spécifié", regularFont),
              _buildRowWithIcon("images", "Droit à l'image :", adherent.image ?? "Non spécifié", regularFont),
              _buildRowWithIcon("sante", "Decharge medical :", adherent.sante ?? "Non spécifié", regularFont),
              _buildRowWithIcon("facture", "Facture :", adherent.invoice ?? "Non spécifié", regularFont),




            ],
          );
        },
      ),
    );

    Uint8List pdfBytes = await pdf.save();

    // Créer un Blob pour le PDF
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Ouvrir le PDF dans un nouvel onglet
    html.window.open(url, '_blank');

    // Libérer l'URL après utilisation
    html.Url.revokeObjectUrl(url);
  } catch (e) {
    debugPrint("Erreur lors de la génération du PDF : $e");
    throw e;
  }
}

pw.Widget _buildRowWithIcon(String emojiName, String label, String value, pw.Font regularFont) {
  final pw.MemoryImage? icon = EmojiUtils.pdfEmoji(emojiName);

  return pw.Row(
    children: [
      if (icon != null) // Vérifie si l’image est bien chargée
        pw.Container(
          width: 18,
          height: 18,
          child: pw.Image(icon),
        ),
      pw.SizedBox(width: 15),
      pw.Text(
        "$label $value",
        style: pw.TextStyle(font: regularFont, fontSize: 14),
      ),
      pw.SizedBox(height: 15),
    ],
  );
}

