import 'package:flutter/cupertino.dart';

import '../../../domain/entities/cotisation.dart';

List<Cheque> parseCheques(String chequesInput) {
  List<Cheque> cheques = [];

  List<String> entries = chequesInput.split(',');

  for (String entry in entries) {
    List<String> chequesData = entry.split(':');

    if (chequesData.length == 2) {
      String numeroChequeStr = chequesData[0].trim();
      String montantChequeStr = chequesData[1].trim();

      try {
        int numeroCheque = int.parse(numeroChequeStr);
        int montantChequeInt = int.parse(montantChequeStr);

        // Ajoutez la paire clé-valeur à la liste de chèques
        debugPrint(
            'Numero de cheque: $numeroCheque, Montant de cheque: $montantChequeInt');
        cheques.add(Cheque(
          numeroCheque:
              numeroCheque.toString(), // Convertir en string si nécessaire
          montantCheque: montantChequeInt,
        ));
      } catch (e) {
        debugPrint('Erreur de conversion pour la chaîne: $entry');
        debugPrint('Erreur détaillée: $e');
      }
    }
  }

  // Tri des chèques par le numéro de chèque
  cheques.sort(
    (a, b) => int.parse(a.numeroCheque).compareTo(int.parse(b.numeroCheque)),
  );

  return cheques;
}
