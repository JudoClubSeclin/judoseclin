import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/ui/common/adherents/bloc/adherents_bloc.dart';
import 'package:judoseclin/ui/common/adherents/bloc/adherents_event.dart';
import 'package:judoseclin/ui/common/adherents/bloc/adherents_state.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../widgets/appbar/custom_appbar.dart';
import '../../widgets/buttons/custom_buttom.dart';
import '../../widgets/inputs/custom_textfield.dart';

class AddAdherentsView extends StatelessWidget {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final licenceController = TextEditingController();
  final bletController = TextEditingController();
  final disciplineController = TextEditingController();
  final categoryController = TextEditingController();
  final tutorController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final imageController = TextEditingController();
  final santeController = TextEditingController();
  final medicalCertificateController = TextEditingController();
  final invoiceController = TextEditingController();
  final payementController = TextEditingController();

  AddAdherentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdherentsBloc, AdherentsState>(
      builder: (context, state) {
        if (state is SignUpLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SignUpErrorState) {
          return Text(state.error);
        } else {
          return _buildForm(context);
        }
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'ajouter un adhérent'),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageFondEcran.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'AJOUTER UN ADHÉRENT',
                  style: titleStyleMedium(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      labelText: 'NOM',
                      controller: firstNameController,
                    ),
                    const SizedBox(width: 40),
                    CustomTextField(
                      labelText: 'PRÉNOM',
                      controller: lastNameController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      labelText: 'Date de naissance (jj/mm/aaaa)',
                      controller: dateOfBirthController,
                    ),
                    const SizedBox(width: 40),
                    CustomTextField(
                      labelText: 'Email',
                      controller: emailController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      labelText: 'Licence',
                      controller: licenceController,
                    ),
                    const SizedBox(width: 40),
                    CustomTextField(
                      labelText: 'Ceinture',
                      controller: bletController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      labelText: 'discipline',
                      controller: disciplineController,
                    ),
                    const SizedBox(width: 40),
                    CustomTextField(
                      labelText: 'Catégorie',
                      controller: categoryController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      labelText: 'Tuteur légal',
                      controller: tutorController,
                    ),
                    const SizedBox(width: 40),
                    CustomTextField(
                      labelText: 'Téléphonne',
                      controller: phoneController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      labelText: 'droit à l\'mage',
                      controller: imageController,
                    ),
                    const SizedBox(width: 40),
                    CustomTextField(
                      labelText: 'Droit medical',
                      controller: santeController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      labelText: 'Certificat médical',
                      controller: medicalCertificateController,
                    ),
                    const SizedBox(width: 40),
                    CustomTextField(
                      labelText: 'Facture',
                      controller: invoiceController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomTextField(
                    labelText: 'Adresse)',
                    controller: addressController,
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  CustomTextField(
                    labelText: 'Paiements (séparés par des virgules)',
                    controller: payementController,
                  ),
                ]),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onPressed: () {
                    try {
                      context.read<AdherentsBloc>().add(
                            SignUpEvent(
                              id: '',
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              email: emailController.text.trim(),
                              dateOfBirth: dateOfBirthController.text.trim(),
                              licence: licenceController.text.trim(),
                              blet: bletController.text.trim(),
                              discipline: disciplineController.text.trim(),
                              category: categoryController.text.trim(),
                              tutor: tutorController.text.trim(),
                              phone: phoneController.text.trim(),
                              address: addressController.text.trim(),
                              image: imageController.text.trim(),
                              sante: santeController.text.trim(),
                              medicalCertificate:
                                  medicalCertificateController.text.trim(),
                              invoice: invoiceController.text.trim(),
                              payement: payementController.text
                                  .split(',')
                                  .map((e) => e.trim())
                                  .toList(),
                            ),
                          );
                      // Réinitialisez les contrôleurs de text
                      firstNameController.clear();
                      lastNameController.clear();
                      emailController.clear();
                      dateOfBirthController.clear();
                      licenceController.clear();
                      bletController.clear();
                      disciplineController.clear();
                      categoryController.clear();
                      tutorController.clear();
                      phoneController.clear();
                      addressController.clear();
                      imageController.clear();
                      santeController.clear();
                      medicalCertificateController.clear();
                      invoiceController.clear();
                      payementController.clear();
                    } catch (e) {
                      debugPrint('Error parsing date: $e');
                      // Handle the error as needed, e.g., show a message to the user
                    }
                  },
                  label: "enregistré",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
