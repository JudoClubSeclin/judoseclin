import 'package:flutter/material.dart';
import 'package:judoseclin/ui/common/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../../../domain/entities/adherents.dart';
import '../../functions/show_edit_text_fiel_dialog.dart';
import '../../theme/theme.dart';

class AdherentsDetailView extends StatelessWidget {
  final String adherentId;
  final AdherentsInteractor adherentsInteractor;

  const AdherentsDetailView(
      {super.key, required this.adherentId, required this.adherentsInteractor});

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
                    alignment: WrapAlignment.center,
                    spacing: 4.0, // Espacement horizontal entre les éléments
                    runSpacing: 9.0, // Espacement vertical entre les lignes
                    children: [
                      //FIRSTNAME
                      const Text(
                        'Nom:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.firstName),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.firstName,
                            labelText: 'Nom',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'firstName',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 35),
                      //LASTNAME
                      const Text(
                        'Prénom:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.lastName),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.lastName,
                            labelText: 'prenom',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'lastName',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 35),
                      //TUTOR
                      const Text(
                        'Tuteur légale:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.tutor),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.tutor,
                            labelText: 'tutor',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'tutor',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 35),
                      //PHONE
                      const Text(
                        'Téléphone:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.phone),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.blet,
                            labelText: 'phone',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'phone',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4.0, // Espacement horizontal entre les éléments
                    runSpacing: 30.0, // Espacement vertical entre les lignes
                    children: [
                      //DISCIPLINE
                      const Text(
                        'discipline:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.discipline),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.discipline,
                            labelText: 'discipline',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'discipline',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 35),
                      //BLET
                      const Text(
                        'Ceinture:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.blet),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.blet,
                            labelText: 'blet',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'blet',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 35),
                      //LICENCE
                      const Text(
                        'Licence:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.licence),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.licence,
                            labelText: 'licence',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'licence',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                      //CATEGORY
                      const Text(
                        'Catégorie:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.category),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.category,
                            labelText: 'category',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'category',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4.0, // Espacement horizontal entre les éléments
                    runSpacing: 30.0, // Espacement vertical entre les lignes
                    children: [
                      //EMAIL
                      const Text(
                        'Email:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.email),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.email,
                            labelText: 'email',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'email',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 35),
                      //ADDRESS
                      const Text(
                        'Adresse:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.address),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.address,
                            labelText: 'address',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'address',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 4.0, // Espacement horizontal entre les éléments
                    runSpacing: 30.0, // Espacement vertical entre les lignes
                    children: [
                      //DROIT A L'IMAGE
                      const Text(
                        'Droit à l\'image:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.image),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.image,
                            labelText: 'email',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'image',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 35),
                      //MEDICALCERTIFICATE
                      const Text(
                        'Certificat médical:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.medicalCertificate),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.medicalCertificate,
                            labelText: 'medicalCertificate',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'medicalCertificate',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 35),
                      //DOIRT AU URGENCE
                      const Text(
                        'Droit médical:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.sante),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.sante,
                            labelText: 'sante',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'sante',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                      const SizedBox(width: 35),
                      //DOIRT AU URGENCE
                      const Text(
                        'Facture:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(adherent.invoice),

                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          String? editedValue = await showEditTextFieldDialog(
                            context: context,
                            initialValue: adherent.invoice,
                            labelText: 'invoice',
                          );
                          if (editedValue != null) {
                            try {
                              // Mettez à jour les données dans Firestore
                              await adherentsInteractor.updateAdherentField(
                                adherent.id,
                                'invoice',
                                editedValue,
                              );
                            } catch (e) {
                              debugPrint(
                                  'Erreur lors de la mise à jour du nom: $e');
                              // Gérez l'erreur selon vos besoins
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ]),
              );
            }
          },
        ),
      ),
    );
  }
}
