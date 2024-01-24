import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:judoseclin/ui/common/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/common/cotisations/interactor/cotisation_interactor.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/buttons/custom_buttom.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../../../domain/entities/adherents.dart';
import '../../../../domain/entities/cotisation.dart';
import '../../theme/theme.dart';
import '../../widgets/infos_fields/infos_fields.dart';

class AdherentsDetailView extends StatelessWidget {
  final String adherentId;
  final AdherentsInteractor adherentsInteractor;
  final CotisationInteractor cotisationInteractor;

  const AdherentsDetailView(
      {super.key,
      required this.adherentId,
      required this.adherentsInteractor,
      required this.cotisationInteractor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Détail adherent'),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImageFondEcran.imagePath),
          fit: BoxFit.cover,
        )),
        child: FutureBuilder(
          future: adherentsInteractor.getAdherentsById(adherentId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Erreur: ${snapshot.error}');
            } else {
              final adherent = snapshot.data as Adherents;

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      adherent.firstName,
                      style: titleStyleMedium(context),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      adherent.lastName,
                      style: titleStyleMedium(context),
                      textAlign: TextAlign.center,
                    ),
                  ]),
                  const SizedBox(
                    height: 50,
                  ),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    //spacing: 4.0, // Espacement horizontal entre les éléments
                    runSpacing: 30.0, // Espacement vertical entre les lignes
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InfoField(
                            label: 'Nom',
                            value: adherent.firstName,
                            field: 'firstName',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                          InfoField(
                            label: 'Prénom',
                            value: adherent.lastName,
                            field: 'lastName',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                          InfoField(
                            label: 'Tuteur légal',
                            value: adherent.tutor,
                            field: 'tutor',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InfoField(
                            label: 'Discipline:',
                            value: adherent.discipline,
                            field: 'discipline',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                          InfoField(
                            label: 'Catégorie:',
                            value: adherent.category,
                            field: 'category',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                          InfoField(
                            label: 'Ceinture:',
                            value: adherent.blet,
                            field: 'blet',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InfoField(
                            label: 'Email:',
                            value: adherent.email,
                            field: 'email',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                          InfoField(
                            label: 'Téléphone:',
                            value: adherent.phone,
                            field: 'phone',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                          InfoField(
                            label: 'adresse:',
                            value: adherent.address,
                            field: 'address',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InfoField(
                            label: 'Droit à l\'image:',
                            value: adherent.image,
                            field: 'image',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                          InfoField(
                            label: 'Urgence:',
                            value: adherent.sante,
                            field: 'sante',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                          InfoField(
                            label: 'Certificat médical:',
                            value: adherent.medicalCertificate,
                            field: 'medicalCertificate',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                          InfoField(
                            label: 'Facture:',
                            value: adherent.invoice,
                            field: 'invoice',
                            adherentsInteractor: adherentsInteractor,
                            adherent: adherent,
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future:
                            cotisationInteractor.getCotisationById(adherentId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Erreur: ${snapshot.error}');
                          } else {
                            var cotisation = snapshot.data;
                            if (cotisation != null &&
                                adherent.id == cotisation.id) {
                              return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CotisationInfoField(
                                                label: 'date',
                                                value: cotisation.date,
                                                field: 'date',
                                                cotisationInteractor:
                                                    cotisationInteractor,
                                                cotisation: cotisation),
                                            CotisationInfoField(
                                                label: 'Banque',
                                                value: cotisation.bankName,
                                                field: 'bankName',
                                                cotisationInteractor:
                                                    cotisationInteractor,
                                                cotisation: cotisation),
                                          ]),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          if (cotisation
                                              .cheques.isNotEmpty) ...[
                                            const Text(''),
                                            for (Cheque cheque
                                                in cotisation.cheques)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CotisationInfoField(
                                                    label: 'Numéro du chèque',
                                                    value: cheque.numeroCheque,
                                                    field: 'cheques',
                                                    cotisationInteractor:
                                                        cotisationInteractor,
                                                    cotisation: cotisation,
                                                  ),
                                                  CotisationInfoField(
                                                    label: 'Montant du chèque:',
                                                    value: cheque.montantCheque
                                                        .toString(),
                                                    field: 'cheque',
                                                    cotisationInteractor:
                                                        cotisationInteractor,
                                                    cotisation: cotisation,
                                                  ),
                                                ],
                                              ),
                                          ] else
                                            CotisationInfoField(
                                              label: 'Montant en espèce',
                                              value:
                                                  cotisation.amount.toString(),
                                              field: 'amount',
                                              cotisationInteractor:
                                                  cotisationInteractor,
                                              cotisation: cotisation,
                                            ),
                                          // Affichage du détail du paiement en espèces ou par chèque
                                        ],
                                      )
                                    ],
                                  ));
                            } else {
                              return CustomButton(
                                label: 'Ajouter la cotisation',
                                onPressed: () => context
                                    .go('/admin/add/cotisation/$adherentId'),
                              );
                            }
                          }
                        },
                      )
                    ],
                  )
                ]),
              );
            }
          },
        ),
      ),
    );
  }
}
