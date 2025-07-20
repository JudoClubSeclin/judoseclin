import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';

import '../../common/widgets/infos_fields/infos_fields.dart';
import '../../cotisations/cotisation_interactor.dart';

class InfoFieldAdherentsCotisation extends StatelessWidget {
  final String adherentId;
  final CotisationInteractor cotisationInteractor;

  const InfoFieldAdherentsCotisation({
    super.key,
    required this.adherentId,
    required this.cotisationInteractor,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cotisationInteractor.getCotisationById(adherentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          var cotisation = snapshot.data;
          if (cotisation != null && adherentId == cotisation.adherentId) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CotisationInfoField(
                        label: 'date',
                        value: cotisation.date,
                        field: 'date',
                        cotisationInteractor: cotisationInteractor,
                        cotisation: cotisation,
                      ),
                      CotisationInfoField(
                        label: 'Banque',
                        value: cotisation.bankName,
                        field: 'bankName',
                        cotisationInteractor: cotisationInteractor,
                        cotisation: cotisation,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (cotisation.cheques.isNotEmpty) ...[
                        const Text(''),
                        for (Cheque cheque in cotisation.cheques)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CotisationInfoField(
                                label: 'Numéro du chèque',
                                value: cheque.numeroCheque,
                                field: 'cheques',
                                cotisationInteractor: cotisationInteractor,
                                cotisation: cotisation,
                              ),
                              CotisationInfoField(
                                label: 'Montant du chèque:',
                                value: cheque.montantCheque.toString(),
                                field: 'cheque',
                                cotisationInteractor: cotisationInteractor,
                                cotisation: cotisation,
                              ),
                            ],
                          ),
                      ] else
                        CotisationInfoField(
                          label: 'Montant en espèce',
                          value: cotisation.amount.toString(),
                          field: 'amount',
                          cotisationInteractor: cotisationInteractor,
                          cotisation: cotisation,
                        ),
                      // Affichage du détail du paiement en espèces ou par chèque
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        }
      },
    );
  }
}
