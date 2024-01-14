import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/ui/common/cotisations/bloc/cotisation_event.dart';
import 'package:judoseclin/ui/common/cotisations/bloc/cotisation_sate.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';
import 'package:judoseclin/ui/common/widgets/buttons/custom_buttom.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/common/widgets/inputs/custom_textfield.dart';

import '../bloc/cotisation_bloc.dart';

class AddCotisationView extends StatelessWidget {
  final String adherentId;
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final chequeNumberController = TextEditingController();
  final chequeAmountController = TextEditingController();
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
    return DecoratedBox(
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
              'Ajouter la cotisation de $adherentId',
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
                  labelText: 'Numéro de chèque',
                  controller: chequeNumberController,
                ),
                CustomTextField(
                  labelText: 'Numéro de chèque',
                  controller: chequeAmountController,
                ),
                CustomTextField(
                  labelText: 'Nom de la banque',
                  controller: bankNameController,
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                try {
                  context.read<CotisationBloc>().add(CotisationSignUpEvent(
                        adherentId: adherentId,
                        amount: amountController.text.trim(),
                        date: dateController.text.trim(),
                        chequeNumber: chequeNumberController.text.trim(),
                        chequeAmount: chequeNumberController.text.trim(),
                        bankName: bankNameController.text.trim(),
                      ));
                } catch (e) {
                  debugPrint('Erreur inattendue: $e');
                  debugPrint(
                      'amountController: ${amountController.text.trim()}');
                  debugPrint('dateController: ${dateController.text.trim()}');
                  debugPrint(
                      'chequeNumberController: ${chequeNumberController.text.trim()}');
                  debugPrint(
                      'chequeAmountController: ${chequeAmountController.text.trim()}');
                  debugPrint(
                      'bankNameController: ${bankNameController.text.trim()}');
                }
              },
              label: 'Enregistrer la cotisation',
            )
          ],
        ),
      ),
    );
  }
}
