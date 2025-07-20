import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';

import '../../../../core/utils/show_edit_text_field_dialog.dart';
import '../../../../theme.dart';
import '../../../adherents/interactor/adherents_interactor.dart';
import '../../../cotisations/cotisation_interactor.dart';

class InfoField extends StatelessWidget {
  final String label;
  final String value;
  final String field;
  final AdherentsInteractor adherentsInteractor;
  final Adherents adherent;

  const InfoField({
    super.key,
    required this.label,
    required this.value,
    required this.field,
    required this.adherentsInteractor,
    required this.adherent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildLabel(context, label),
        _buildValue(context, value),
        _buildEditButton(context),
      ],
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        text,
        style: textStyleText(context).copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildValue(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: textStyleText(context)),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: const Icon(Icons.edit),
        color: Theme.of(context).colorScheme.onPrimary,
        onPressed: () async {
          String? editedValue = await myShowEditTextFieldDialog(
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
        _buildLabel(context, label),
        _buildValue(context, value),
        _buildEditButton(context),
      ],
    );
  }

  Widget _buildLabel(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: textStyleText(
          context,
        ).copyWith(fontWeight: FontWeight.bold), // 🔥 Style du thème + gras
      ),
    );
  }

  Widget _buildValue(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: textStyleText(context), // 🔥 Style du thème
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () async {
          String? editedValue = await myShowEditTextFieldDialog(
            context: context,
            initialValue: value,
            labelText: field,
          );
          if (editedValue != null) {
            try {
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
            }
          }
        },
      ),
    );
  }
}
