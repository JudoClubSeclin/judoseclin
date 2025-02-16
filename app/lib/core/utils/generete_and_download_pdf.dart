import 'dart:typed_data';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;
import 'package:flutter/services.dart';

Future<void> generateAndDownloadPdf(Adherents adherent) async {
  final pdf = pw.Document();
  final regularFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
  final boldFont = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Bold.ttf"));

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Fiche Adhérent", style: pw.TextStyle(fontSize: 24, font: boldFont, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text("Nom : ${adherent.firstName}", style: pw.TextStyle(fontSize: 18)),
            pw.Text("Prénom : ${adherent.lastName}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("responsable legal : ${adherent.tutor}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("Email : ${adherent.email}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("Téléphone : ${adherent.phone}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("adresse : ${adherent.address}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("date de naissance : ${adherent.dateOfBirth}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("ceinture : ${adherent.belt}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("catégorie : ${adherent.category}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("discipline : ${adherent.discipline}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("licence : ${adherent.licence}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("Droit a l'image : ${adherent.image}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("certificat_medical : ${adherent.medicalCertificate}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("décharge medical : ${adherent.sante}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),
            pw.Text("facture : ${adherent.invoice}", style: pw.TextStyle(fontSize: 18, font: regularFont,)),


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
}
