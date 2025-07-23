import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/common/widgets/inputs/custom_textfield.dart';
import '../../common/widgets/appbar/custom_appbar.dart';
import '../../common/widgets/buttons/custom_buttom.dart';
import '../adherents_bloc.dart';
import '../adherents_event.dart';
import '../adherents_state.dart';

class AddAdherentsView extends StatefulWidget {
  const AddAdherentsView({super.key});

  @override
  State<AddAdherentsView> createState() => _AddAdherentsViewState();
}

class _AddAdherentsViewState extends State<AddAdherentsView> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final licenceController = TextEditingController();
  final beltController = TextEditingController();
  final disciplineController = TextEditingController();
  final categoryController = TextEditingController();
  final tutorController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final imageController = TextEditingController();
  final santeController = TextEditingController();
  final medicalCertificateController = TextEditingController();
  final invoiceController = TextEditingController();
  final additionalAddressController = TextEditingController();

  String? currentFamilyId; // Pour stocker familyId détecté

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    dateOfBirthController.dispose();
    licenceController.dispose();
    beltController.dispose();
    disciplineController.dispose();
    categoryController.dispose();
    tutorController.dispose();
    phoneController.dispose();
    addressController.dispose();
    imageController.dispose();
    santeController.dispose();
    medicalCertificateController.dispose();
    invoiceController.dispose();
    additionalAddressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdherentsBloc, AdherentsState>(
      listener: (context, state) {
        if (state is FamilyCheckSuccessState) {
          // Préremplir email, téléphone et mémoriser familyId
          emailController.text = state.email;
          phoneController.text = state.phone;
          currentFamilyId = state.familyId;
        }
      },
      child: BlocBuilder<AdherentsBloc, AdherentsState>(
        builder: (context, state) {
          if (state is SignUpLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SignUpErrorState) {
            return Center(child: Text(state.error));
          } else if (state is SignUpSuccessState) {
            return _buildForm(context, state.adherentId);
          } else {
            return _buildForm(context, '');
          }
        },
      ),
    );
  }

  Widget _buildForm(BuildContext context, String adherentId) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      drawer: MediaQuery.sizeOf(context).width > 750 ? null : CustomDrawer(),
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
                      labelText: 'Adresse',
                      controller: addressController,
                      onChanged: (value) {
                        if (value.trim().length >= 5) {
                          // Déclenche l'événement Bloc pour vérifier la famille
                          context.read<AdherentsBloc>().add(
                                CheckFamilyByAddressEvent(value.trim()),
                              );
                        }
                      },
                    ),
                    CustomTextField(
                      labelText: "Suplément d'adresse",
                      controller: additionalAddressController,
                    ),
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
                      controller: beltController,
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
                      labelText: 'Téléphone',
                      controller: phoneController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: 'droit à l\'image',
                      controller: imageController,
                    ),
                    const SizedBox(width: 40),
                    CustomTextField(
                      labelText: 'Décharge médicale',
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
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  onPressed: () async {
                    try {
                      DateTime parsedDate = DateFormat('dd/MM/yyyy')
                          .parse(dateOfBirthController.text.trim());

                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(parsedDate);

                      String familyId;

                      if (currentFamilyId != null &&
                          currentFamilyId!.isNotEmpty) {
                        familyId = currentFamilyId!;
                      } else {
                        familyId = addressController.text
                            .trim()
                            .toLowerCase()
                            .replaceAll(' ', '_');
                      }

                      context.read<AdherentsBloc>().add(
                            AddAdherentsSignUpEvent(
                              id: '',
                              firstName: firstNameController.text.trim(),
                              lastName: lastNameController.text.trim(),
                              email: emailController.text.trim(),
                              dateOfBirth: formattedDate,
                              licence: licenceController.text.trim(),
                              additionalAddress:
                                  additionalAddressController.text.trim(),
                              belt: beltController.text.trim(),
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
                              userExists: false,
                              familyId: familyId,
                            ),
                          );

                      // Réinitialiser les champs et la famille détectée
                      firstNameController.clear();
                      lastNameController.clear();
                      emailController.clear();
                      dateOfBirthController.clear();
                      licenceController.clear();
                      beltController.clear();
                      disciplineController.clear();
                      categoryController.clear();
                      tutorController.clear();
                      phoneController.clear();
                      addressController.clear();
                      imageController.clear();
                      santeController.clear();
                      medicalCertificateController.clear();
                      invoiceController.clear();
                      additionalAddressController.clear();
                      currentFamilyId = null;
                    } catch (e) {
                      debugPrint(
                          'Erreur lors de l\'enregistrement ou de l\'envoi de l\'e-mail : $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Erreur lors du traitement des données: $e'),
                        ),
                      );
                    }
                  },
                  label: "Enregistrer",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
