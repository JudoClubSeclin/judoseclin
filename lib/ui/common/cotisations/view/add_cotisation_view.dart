import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/ui/common/cotisations/bloc/cotisation_event.dart';
import 'package:judoseclin/ui/common/cotisations/bloc/cotisation_sate.dart';
import 'package:judoseclin/ui/common/functions/parse_cheques.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';
import 'package:judoseclin/ui/common/widgets/buttons/custom_buttom.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/common/widgets/inputs/custom_textfield.dart';

import '../../widgets/appbar/custom_appbar.dart';
import '../bloc/cotisation_bloc.dart';

class AddCotisationView extends StatelessWidget {
  final String adherentId;
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final chequesController = TextEditingController();
  final bankNameController = TextEditingController();

  AddCotisationView({super.key, required this.adherentId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CotisationBloc, CotisationState>(
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
    });
  }

  Widget _buildForm(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'ajouter la cotisation'),
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(ImageFondEcran.imagePath),
          fit: BoxFit.cover,
        )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'Ajouter la cotisation ',
                style: titleStyleMedium(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                    labelText: 'Espèce',
                    controller: amountController,
                  ),
                  CustomTextField(
                    labelText: 'Date',
                    controller: dateController,
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextField(
                    labelText: 'Numero : montant du cheque  ',
                    controller: chequesController,
                  ),
                  CustomTextField(
                    labelText: 'Nom de la banque ',
                    controller: bankNameController,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  try {
                    debugPrint('bouton appuyer');
                    // Utilisez la fonction parseCheques pour obtenir la liste des chèques.
                    var cheques = parseCheques(chequesController.text.trim());

                    context.read<CotisationBloc>().add(CotisationSignUpEvent(
                          id: 'adherentId',
                          adherentId: adherentId,
                          amount: int.parse(amountController.text.trim()),
                          date: dateController.text.trim(),
                          cheques: cheques,
                          bankName: bankNameController.text.trim(),
                        ));
                  } catch (e) {
                    debugPrint('Erreur inattendue: $e');
                  }
                },
                label: 'Enregistrer la cotisation',
              )
            ],
          ),
        ),
      ),
    );
  }
}