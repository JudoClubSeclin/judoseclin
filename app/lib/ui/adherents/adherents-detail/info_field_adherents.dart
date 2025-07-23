// InfoFieldAdherents
import 'package:flutter/material.dart';

import '../../../../theme.dart';
import '../../common/widgets/infos_fields/infos_fields.dart';
import '../adherents_interactor.dart';

class InfoFieldAdherents extends StatelessWidget {
  final String adherentId;
  final AdherentsInteractor adherentsInteractor;

  const InfoFieldAdherents({
    super.key,
    required this.adherentsInteractor,
    required this.adherentId,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: adherentsInteractor.getAdherentsById(adherentId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          final adherent = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Nom et prénom
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    '${adherent.firstName} ${adherent.lastName}',
                    style: titleStyleMedium(context),
                    textAlign: TextAlign.center,
                  ),
                ),

                // Champs d'information
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1000), // Largeur max
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      InfoField(
                        label: 'Nom :',
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
                        value: adherent.tutor!,
                        field: 'tutor',
                        adherentsInteractor: adherentsInteractor,
                        adherent: adherent,
                      ),
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
                        value: adherent.belt,
                        field: 'blet',
                        adherentsInteractor: adherentsInteractor,
                        adherent: adherent,
                      ),
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
                ),
              ],
            ),
          );
        }
      },
    );
  }
}