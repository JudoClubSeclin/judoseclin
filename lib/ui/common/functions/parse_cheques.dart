import 'package:flutter/cupertino.dart';

import '../../../domain/entities/cotisation.dart';

List<Cheque> parseCheques(String chequesInput) {
  List<Cheque> cheques = [];

  List<String> entries = chequesInput.split(',');

  for (String entry in entries) {
    List<String> chequesData = entry.split(':');

    if (chequesData.length == 2) {
      String numeroCheque = chequesData[0].trim();
      String montantChequeStr = chequesData[1].trim();

      // Vous pouvez supprimer la ligne suivante qui nettoie la chaîne
      // montantChequeStr = montantChequeStr.replaceAll(RegExp(r'[^0-9]'), '');

      debugPrint(
        'Numero de cheque: $numeroCheque, Montant de cheque: $montantChequeStr',
      );

      cheques.add(Cheque(
        numeroCheque: numeroCheque,
        montantCheque: montantChequeStr,
      ));
    }
  }

  // Tri des chèques par le numéro de chèque
  cheques.sort(
    (a, b) => int.parse(a.numeroCheque).compareTo(int.parse(b.numeroCheque)),
  );

  return cheques;
}
