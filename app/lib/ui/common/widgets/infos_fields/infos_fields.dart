import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';

import '../../../adherents/interactor/adherents_interactor.dart';
import '../../../cotisations/interactor/cotisation_interactor.dart';
import '../../functions/show_edit_text_fiel_dialog.dart';

class InfoField extends StatelessWidget {
  final String label;
  final String value;
  final String field;
  final AdherentsInteractor adherentsInteractor;
  final Adherents adherent; // Ajoutez le paramètre adherent ici

  const InfoField({
    super.key,
    required this.label,
    required this.value,
    required this.field,
    required this.adherentsInteractor,
    required this.adherent, // Ajoutez cette ligne pour recevoir l'adhérent
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildLabel(label),
        _buildValue(value),
        _buildEditButton(context),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildValue(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          String? editedValue = await showEditTextFieldDialog(
            context: context,
            initialValue: value,
            labelText: field,
          );
          if (editedValue != null) {
            try {
              await adherentsInteractor.updateAdherentField(
                adherentId: adherent.id,
                fieldName: field,
                newValue: editedValue,
              );
            } catch (e) {
              debugPrint('Erreur lors de la mise à jour de $field: $e');
              // Gérez l'erreur selon vos besoins
            }
          }
        },
      ),
    );
  }
}

class CotisationInfoField extends StatelessWidget {
  final String label;
  final String value;
  final String field;
  final CotisationInteractor cotisationInteractor;
  final Cotisation cotisation;

  const CotisationInfoField({
    super.key,
    required this.label,
    required this.value,
    required this.field,
    required this.cotisationInteractor,
    required this.cotisation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildLabel(label),
        _buildValue(value),
        _buildEditButton(context),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildValue(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          String? editedValue = await showEditTextFieldDialog(
            context: context,
            initialValue: value,
            labelText: field,
          );
          if (editedValue != null) {
            try {
              // Convertissez le montant du chèque en String ici si nécessaire
              if (field == 'montant' && cotisation.cheques.isNotEmpty) {
                editedValue = int.parse(editedValue).toString();
              }

              await cotisationInteractor.updateCotisationField(
                cotisationId: cotisation.id,
                fieldName: field,
                newValue: editedValue,
              );
            } catch (e) {
              debugPrint('Erreur lors de la mise à jour de $field: $e');
              // Gérez l'erreur selon vos besoins
            }
          }
        },
      ),
    );
  }
}
