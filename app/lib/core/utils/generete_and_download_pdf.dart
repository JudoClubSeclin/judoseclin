import 'dart:typed_data';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

import '../../ui/adherents/interactor/adherents_interactor.dart';



Future<void> generateAndDownloadPdf(String adherentId, AdherentsInteractor adherentsInteractor) async {
  if (adherentId.isEmpty) {
    print("Erreur : L'ID de l'adhérent est vide !");
    return;
  }

  try {
    print("Fetching adherents data...");
    final adherent = await adherentsInteractor.getAdherentsById(adherentId);

    if (adherent == null) {
      print("Erreur : Aucun adhérent trouvé avec cet ID !");
      return;
    }

    final pdf = pw.Document();

    // Chargement des polices
    final regularFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
    final boldFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf"));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Fiche Adhérent", style: pw.TextStyle(fontSize: 24, font: boldFont)),
              pw.SizedBox(height: 20),
              pw.Text("Nom : ${adherent.firstName}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Prénom : ${adherent.lastName}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Responsable légal : ${adherent.tutor}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Email : ${adherent.email}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Téléphone : ${adherent.phone}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Adresse : ${adherent.address}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Date de naissance : ${adherent.dateOfBirth}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Ceinture : ${adherent.belt}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Catégorie : ${adherent.category}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Discipline : ${adherent.discipline}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Licence : ${adherent.licence}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Droit à l'image : ${adherent.image}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Certificat médical : ${adherent.medicalCertificate}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Décharge médicale : ${adherent.sante}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
              pw.Text("Facture : ${adherent.invoice}", style: pw.TextStyle(fontSize: 18, font: regularFont)),
            ],
          );
        },
      ),
    );

    Uint8List pdfBytes = await pdf.save();

    final blob = html.Blob([pdfBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "Fiche_Adherent_${adherent.firstName}.pdf")
      ..click();

    html.Url.revokeObjectUrl(url);
    print("PDF généré et téléchargé !");
  } catch (e) {
    print("Erreur lors de la récupération de l'adhérent ou de la génération du PDF : $e");
  }
}
