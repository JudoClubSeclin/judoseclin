import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

import '../../ui/adherents/adherents_interactor.dart';
import '../../ui/cotisations/cotisation_interactor.dart';
import 'emojis.dart';

Future<void> generateAndPrintPdf(
    String adherentId,
    AdherentsInteractor adherentsInteractor,
    CotisationInteractor cotisationInteractor,
    ) async {
  if (adherentId.isEmpty) {
    debugPrint("Erreur : L'ID de l'adhérent est vide !");
    return;
  }

  try {
    final adherent = await adherentsInteractor.getAdherentsById(adherentId);
    final cotisations = await cotisationInteractor.fetchCotisationsByAdherentId(adherentId);

    if (adherent == null) {
      debugPrint("Erreur : Aucun adhérent trouvé avec cet ID !");
      return;
    }

    final pdf = pw.Document();

    final regularFont = pw.Font.ttf(
      await rootBundle.load("assets/fonts/Roboto-Regular.ttf"),
    );

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
              _buildRowWithIcon("personne", "Nom :", adherent.firstName, regularFont),
              _buildRowWithIcon("personne", "Prénom :", adherent.lastName, regularFont),
              _buildRowWithIcon("tuteur", "Tuteur legal :", adherent.tutor ?? "Non spécifié", regularFont),
              _buildRowWithIcon("calandrier", "Date de naissance :", adherent.dateOfBirth, regularFont),
              _buildRowWithIcon("adresse", "Adresse :", adherent.address, regularFont),
              _buildRowWithIcon("email", "Email :", adherent.email, regularFont),
              _buildRowWithIcon("phone", "Téléphone :", adherent.phone, regularFont),
              _buildRowWithIcon("ceinture", "Ceinture :", adherent.belt ?? "-", regularFont),
              _buildRowWithIcon("discipline", "Discipline :", adherent.discipline ?? "_", regularFont),
              _buildRowWithIcon("position", "Poste occupé :", adherent.boardPosition ??"_", regularFont),
              _buildRowWithIcon("categorie", "Catégorie :", adherent.category ?? "-", regularFont),
              _buildRowWithIcon("certificate", "Certificat médical :", adherent.medicalCertificate, regularFont),
              _buildRowWithIcon("licence", "Licence :", adherent.licence, regularFont),
              _buildRowWithIcon("images", "Droit à l'image :", adherent.image, regularFont),
              _buildRowWithIcon("sante", "Décharge médicale :", adherent.sante, regularFont),
              _buildRowWithIcon("facture", "Facture :", adherent.invoice, regularFont),

              pw.SizedBox(height: 30),
              pw.Text("Cotisations", style: pw.TextStyle(font: regularFont, fontSize: 16, fontWeight: pw.FontWeight.bold)),

              if (cotisations.isEmpty)
                pw.Text("Aucune cotisation disponible", style: pw.TextStyle(font: regularFont, fontSize: 12))
              else
                pw.Column(
                  children: cotisations.map((cotisation) {
                    return pw.Container(
                      margin: const pw.EdgeInsets.symmetric(vertical: 8),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.grey),
                        borderRadius: pw.BorderRadius.circular(6),
                      ),
                      padding: const pw.EdgeInsets.all(8),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Date : ${cotisation.date}", style: pw.TextStyle(font: regularFont, fontSize: 12)),
                          pw.Text("Banque : ${cotisation.bankName}", style: pw.TextStyle(font: regularFont, fontSize: 12)),
                          pw.SizedBox(height: 6),
                          if (cotisation.cheques.isNotEmpty)
                            pw.Column(
                              children: cotisation.cheques.map((cheque) {
                                return pw.Column(
                                  children: [
                                    pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                      children: [
                                        pw.Column(
                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text('N° chèque: ${cheque.numeroCheque}', style: pw.TextStyle(fontSize: 10)),
                                            pw.Text('Montant: ${cheque.montantCheque} ', style: pw.TextStyle(fontSize: 10)),
                                          ],
                                        ),
                                        pw.Container(
                                          width: 12,
                                          height: 12,
                                          decoration: pw.BoxDecoration(
                                            border: pw.Border.all(width: 1),
                                          ),
                                        ),
                                      ],
                                    ),

                                    pw.Divider(),
                                  ],
                                );
                              }).toList(),
                            )
                          else
                            pw.Text("Montant en espèces: ${cotisation.amount}€", style: pw.TextStyle(font: regularFont, fontSize: 12)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
            ],
          );
        },
      ),
    );

    final pdfBytes = await pdf.save();
    await downloadPdf(pdfBytes, 'fiche_adherent_${adherent.firstName}_${adherent.lastName}.pdf');
  } catch (e) {
    debugPrint("Erreur lors de la génération du PDF : $e");
    rethrow;
  }
}

Future<void> downloadPdf(Uint8List pdfBytes, String fileName) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(pdfBytes);
    await OpenFile.open(file.path);
  } catch (e) {
    debugPrint('Erreur lors du téléchargement: $e');
  }
}

pw.Widget _buildRowWithIcon(String emojiName, String label, String value, pw.Font regularFont) {
  final pw.MemoryImage? icon = EmojiUtils.pdfEmoji(emojiName);

  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 8),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        if (icon != null) pw.Container(width: 18, height: 18, child: pw.Image(icon)),
        pw.SizedBox(width: 10),
        pw.Expanded(
          child: pw.Text(
            "$label $value",
            style: pw.TextStyle(font: regularFont, fontSize: 14),
          ),
        ),
      ],
    ),
  );
}