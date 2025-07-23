import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';
import 'package:judoseclin/theme.dart';

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
    debugPrint('InfoFieldAdherentsCotisation: build for adherentId=$adherentId');

    return FutureBuilder<Iterable<Cotisation>>(
      future: cotisationInteractor.fetchCotisationsByAdherentId(adherentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          final cotisations = snapshot.data ?? [];
          debugPrint('Nombre de cotisations récupérées: ${cotisations.length}');

          if (cotisations.isEmpty) {
            return const Text('Aucune cotisation trouvée');
          }

          return Column(
            children: cotisations.map((cotisation) {
              return Container(
                key: ValueKey(cotisation.id),
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: theme.colorScheme.primary),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLabelValue(context, 'Date', cotisation.date),
                        _buildLabelValue(context, 'Banque', cotisation.bankName),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (cotisation.cheques.isNotEmpty)
                      Column(
                        children: cotisation.cheques.map((cheque) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: _buildLabelValue(
                                      context,
                                      'N° chèque',
                                      cheque.numeroCheque,
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildLabelValue(
                                      context,
                                      'Montant',
                                      '${cheque.montantCheque}€',
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: theme.colorScheme.primary,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Divider(color: theme.colorScheme.primary),
                            ],
                          );
                        }).toList(),
                      )
                    else
                      _buildLabelValue(context, 'Montant en espèce', '${cotisation.amount}€'),
                  ],
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildLabelValue(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textStyleText(context)),
        const SizedBox(height: 4),
        Text(value, style: textStyleText(context)),
      ],
    );
  }
}
