import 'package:flutter/material.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/buttons/custom_buttom.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';
import 'package:judoseclin/ui/common/widgets/inputs/custom_textfield.dart';

import '../../../domain/entities/cotisation.dart';
import '../../common/widgets/appbar/custom_appbar.dart';
import '../cotisation_interactor.dart';


class AddCotisationView extends StatefulWidget {
  final CotisationInteractor cotisationInteractor;
  final String adherentId;
  const AddCotisationView({super.key, required this.adherentId, required this.cotisationInteractor});

  @override
  State<AddCotisationView> createState() => _AddCotisationViewState();
}

class _AddCotisationViewState extends State<AddCotisationView> {
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  final bankNameController = TextEditingController();

  List<TextEditingController> chequeNumberControllers = [];
  List<TextEditingController> chequeAmountControllers = [];

  @override
  void initState() {
    super.initState();
    addChequeField();  // On démarre avec un chèque par défaut
  }

  void addChequeField() {
    if (chequeNumberControllers.length < 4) {
      setState(() {
        chequeNumberControllers.add(TextEditingController());
        chequeAmountControllers.add(TextEditingController());
      });
    }
  }

  void removeChequeField(int index) {
    setState(() {
      chequeNumberControllers[index].dispose();
      chequeAmountControllers[index].dispose();
      chequeNumberControllers.removeAt(index);
      chequeAmountControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    dateController.dispose();
    bankNameController.dispose();
    for (var controller in chequeNumberControllers) {
      controller.dispose();
    }
    for (var controller in chequeAmountControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: '',),
        drawer: MediaQuery.sizeOf(context).width > 750 ? null : CustomDrawer(),
      body:  Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageFondEcran.imagePath),
            fit: BoxFit.cover,
          ),
        ),

        child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Ajouter la cotisation", style: titleStyleMedium(context),),
            const SizedBox(height: 55,),
            // Espèces, date, banque...
            CustomTextField(
                labelText: 'Espèce', controller: amountController),
            const SizedBox(height: 20),
          CustomTextField(labelText:' Date', controller: dateController),
            const SizedBox(height: 20),
           CustomTextField(labelText: "Non de la banque", controller: bankNameController),
            const SizedBox(height: 20),
            // Liste des chèques
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: chequeNumberControllers.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: chequeNumberControllers[index],
                        style: textStyleText(context),
                        decoration: InputDecoration(
                          labelText: 'N° chèque',
                          labelStyle: textStyleText(context),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red.shade400),
                          ),
                          floatingLabelStyle: TextStyle(color: Colors.red.shade400),
                        )
                        ),
                      ),

                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: chequeAmountControllers[index],
                        keyboardType: TextInputType.number,
                        style: textStyleText(context),
                        decoration: InputDecoration(
                labelText: 'Motant du chèque',
                labelStyle: textStyleText(context),
                enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red.shade400),
                ),
                floatingLabelStyle: TextStyle(color: Colors.red.shade400),
                )
                        ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => removeChequeField(index),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 50),

            CustomButton(
              onPressed: addChequeField,
              label: 'Ajouter un chèque',
            ),

            const SizedBox(height: 20),

           CustomButton(
             onPressed: () async {
               List<Cheque> cheques = [];
               for (int i = 0; i < chequeNumberControllers.length; i++) {
                 String num = chequeNumberControllers[i].text.trim();
                 String montantStr = chequeAmountControllers[i].text.trim();
                 int montant = int.tryParse(montantStr) ?? 0;
                 if (num.isNotEmpty && montant > 0) {
                   cheques.add(Cheque(numeroCheque: num, montantCheque: montant));
                 }
               }

               final amount = int.tryParse(amountController.text.trim()) ?? 0;
               final date = dateController.text.trim();
               final bankName = bankNameController.text.trim();

               final cotisation = Cotisation(
                 adherentId: widget.adherentId,
                 amount: amount,
                 date: date,
                 bankName: bankName,
                 cheques: cheques, id: '',
               );

               try {
                 await widget.cotisationInteractor.addCotisation(cotisation);
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text('Cotisation enregistrée')),
                 );
                 Navigator.of(context).pop(); // revenir à la page précédente
               } catch (e) {
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text('Erreur: $e')),
                 );
               }
             },

             label: 'Enregistrer la cotisation',
            ),
          ],
        ),
      ),
      )
    );
  }
}
