import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;
import 'package:flutter/services.dart' show Uint8List, rootBundle;

import '../../ui/adherents/interactor/adherents_interactor.dart';

Future<void> generateAndPrintPdf(String adherentId, AdherentsInteractor adherentsInteractor) async {
  if (adherentId.isEmpty) {
    print("Erreur : L'ID de l'adhérent est vide !");
    return;
  }

  try {
    print("Fetching adherent data...");
    final adherent = await adherentsInteractor.getAdherentsById(adherentId);

    if (adherent == null) {
      print("Erreur : Aucun adhérent trouvé avec cet ID !");
      return;
    }

    final pdf = pw.Document();

    // Chargement des polices
    final regularFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
    final boldFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf"));
    // Chargement d'une police de symboles
    final symbolFont = pw.Font.ttf(await rootBundle.load("assets/fonts/NotoColorEmoji-Regular.ttf"));


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
              _buildRow("\u2709 Date de naissance :", formattedDateOfBirth, boldFont, regularFont),
              _buildRow("\u2022 Nom :", adherent.firstName ?? "Non spécifié", boldFont, regularFont),
              _buildRow("\u2022 Prénom :", adherent.lastName ?? "Non spécifié", boldFont, regularFont),
              _buildRow("\u2022 Responsable légal :", adherent.tutor ?? "Non spécifié", boldFont, regularFont),
              _buildRow("\u2709 Email :", adherent.email ?? "Non spécifié", boldFont, regularFont),
              _buildRow("\u260E Téléphone :", adherent.phone ?? "Non spécifié", boldFont, regularFont),
              _buildRow("\u2302 Adresse:", adherent.address ?? "Non spécifiée", boldFont, regularFont),
              _buildRow("\u2691 Ceinture  :", adherent.belt ?? "Non spécifiée", boldFont, regularFont),
              _buildRow("\u2606 Catégorie:", adherent.category ?? "Non spécifiée", boldFont, regularFont),
              _buildRow("\u2605 Discipline :", adherent.discipline ?? "Non spécifiée", boldFont, regularFont),
              _buildRow("\u2713 Licence :", adherent.licence ?? "Non spécifiée", boldFont, regularFont),
              _buildRow("\u2315 Droit à l'image :", adherent.image ?? "Non spécifié", boldFont, regularFont),
              _buildRow("\u2695 Certificat médical  :", adherent.medicalCertificate ?? "Non spécifié", boldFont, regularFont),
              _buildRow("\u26A0 Décharge médicale :", adherent.sante ?? "Non spécifiée", boldFont, regularFont),
              _buildRow("\u2611 Facture  :", adherent.invoice ?? "Non spécifiée", boldFont, regularFont),
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
    print("Erreur lors de la génération du PDF : $e");
    throw e;
  }
}

pw.Widget _buildRow(String label, String value, pw.Font boldFont, pw.Font regularFont) {
  return pw.Padding(
    padding: pw.EdgeInsets.only(bottom: 10),
    child: pw.Row(
      children: [
        pw.Text(label, style: pw.TextStyle(fontSize: 14, font: boldFont)),
        pw.SizedBox(width: 5),
        pw.Text(value, style: pw.TextStyle(fontSize: 14, font: regularFont)),
      ],
    ),
  );
}