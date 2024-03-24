import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/common/widgets/inputs/custom_textfield.dart';

import '../../common/widgets/appbar/custom_appbar.dart';
import '../../common/widgets/buttons/custom_buttom.dart';
import '../bloc/adherents_bloc.dart';
import '../bloc/adherents_event.dart';
import '../bloc/adherents_state.dart';

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

  AddAdherentsView({super.key, required adherentsRepository});

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
        } else if (state is SignUpSuccessState) {
          return _buildForm(context, state.adherentId);
        } else {
          return _buildForm(context, '');
        }
      },
    );
  }

  Widget _buildForm(BuildContext context, String adherentId) {
    return Scaffold(
        appBar: const CustomAppBar(title: ''),
        drawer: MediaQuery.sizeOf(context).width > 750
            ? null
            : const CustomDrawer(),
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
                  Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 40.0,
                      runSpacing: 20.0,
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
                        const SizedBox(height: 20),
                        CustomTextField(
                          labelText: 'Date de naissance (jj/mm/aaaa)',
                          controller: dateOfBirthController,
                        ),
                        const SizedBox(width: 40),
                        CustomTextField(
                          labelText: 'Email',
                          controller: emailController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          labelText: 'Licence',
                          controller: licenceController,
                        ),
                        const SizedBox(width: 40),
                        CustomTextField(
                          labelText: 'Ceinture',
                          controller: bletController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          labelText: 'discipline',
                          controller: disciplineController,
                        ),
                        const SizedBox(width: 40),
                        CustomTextField(
                          labelText: 'Catégorie',
                          controller: categoryController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          labelText: 'Tuteur légal',
                          controller: tutorController,
                        ),
                        const SizedBox(width: 40),
                        CustomTextField(
                          labelText: 'Téléphonne',
                          controller: phoneController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          labelText: 'droit à l\'mage',
                          controller: imageController,
                        ),
                        const SizedBox(width: 40),
                        CustomTextField(
                          labelText: 'Droit medical',
                          controller: santeController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          labelText: 'Certificat médical',
                          controller: medicalCertificateController,
                        ),
                        const SizedBox(width: 40),
                        CustomTextField(
                          labelText: 'Facture',
                          controller: invoiceController,
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          labelText: 'Adresse)',
                          controller: addressController,
                        ),
                      ]),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () async {
                      try {
                        //Convertir la chainede date en objet DateTime
                        DateTime parsedDate = DateFormat('dd/MM/yyyy')
                            .parse(dateOfBirthController.text.trim());
                        // Save adherent and get the adherentId
                        context.read<AdherentsBloc>().add(
                              AddAdherentsSignUpEvent(
                                id: '',
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                email: emailController.text.trim(),
                                dateOfBirth: parsedDate,
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
                                adherentId: '',
                              ),
                            );

                        // Reset text controllers
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
                      } catch (e) {
                        debugPrint('Error processing data: $e');
                        // Handle the error as needed, e.g., show a message to the user
                      }
                    },
                    label: "Enregistrer",
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
