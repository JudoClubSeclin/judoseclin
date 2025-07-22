import 'package:flutter/material.dart';

double calculateTitleFontSize(BuildContext context, {double? ratio}) {
  final size = MediaQuery.sizeOf(context);
  // Utiliser un ratio pour adapter la taille des titres
  return ratio != null
      ? (size.width > 749 ? size.width / ratio : 35)
      : (size.width > 749 ? size.width / 25 : 35); // Valeur par défaut
}

double calculateFontSize(BuildContext context, {double? ratio}) {
  final size = MediaQuery.sizeOf(context);
  // Ratio pour le texte classique
  return ratio != null
      ? (size.width > 749 ? size.width / ratio : 16)
      : (size.width > 749 ? size.width / 95 : 16); // Valeur par défaut
}