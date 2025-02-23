import 'package:flutter/cupertino.dart';

import '../../domain/entities/cotisation.dart';

List<Cheque> parseCheques(String chequesInput) {
  List<Cheque> cheques = [];

  List<String> entries = chequesInput.split(',');

  for (String entry in entries) {
    List<String> chequesData = entry.split(':');

    if (chequesData.length == 2) {
      String numeroChequeStr = chequesData[0].trim();
      String montantChequeStr = chequesData[1].trim();

      String numeroCheque = numeroChequeStr;
      debugPrint(
        'Valeur de montantChequeStr avant la conversion : $montantChequeStr',
      );
      int montantChequeInt = int.parse(montantChequeStr);
      debugPrint(
        'Valeur de montantChequeInt après la conversion : $montantChequeInt',
      );

      cheques.add(
        Cheque(
          numeroCheque: numeroCheque, // Convertir en string si nécessaire
          montantCheque: montantChequeInt,
        ),
      );
    }
  }

  // Tri des chèques par le numéro de chèque

  cheques.sort((a, b) => a.numeroCheque.compareTo(b.numeroCheque));

  return cheques;
}
