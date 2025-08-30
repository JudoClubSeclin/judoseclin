import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/ui/account/donnees_user/donnees_user.dart';

import '../../../theme.dart';
import '../../common/widgets/images/image_fond_ecran.dart';

class AccountView extends StatelessWidget {
  final Map<String, dynamic> userData;

  const AccountView({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final utilisateurPrincipal = Adherents(
      id: userData['id'] ?? '',
      lastName: userData['lastName'] ?? '',
      firstName: userData['firstName'] ?? '',
      familyId: userData['familyId'] ?? '',
      dateOfBirth: _toStringDate(userData['dateOfBirth']),
      belt: userData['belt'] ?? '',
      email: userData['email'] ?? '',
      licence: userData['licence'] ?? '',
      discipline: userData['discipline'] ?? '',
      boardPosition: userData['boardPosition'] ?? '',
      tutor: userData['tutor'] ?? '',
      category: userData['category'] ?? '',
      phone: userData['phone'] ?? '',
      address: userData['address'] ?? '',
      image: userData['image'] ?? '',
      sante: userData['sante'] ?? '',
      medicalCertificate: userData['medicalCertificate'] ?? '',
      invoice: userData['invoice'] ?? '',
      additionalAddress: userData['additionalAddress'] ?? '',
      postalCode: userData['postalCode'] ?? '',
    );


    final List<Adherents> adherents = [utilisateurPrincipal];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageFondEcran.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text(
                      'Bonjour la famille',
                      style: titleStyleMedium(context),
                    ),
                    const SizedBox(width: 22),
                    Text(
                      utilisateurPrincipal.firstName,
                      style: titleStyleMedium(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DonneesUser(
                  adherents: adherents,
                  utilisateurPrincipal: utilisateurPrincipal,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
String _toStringDate(dynamic value) {
  if (value == null) return '';
  if (value is String) return value;
  if (value is DateTime) {
    return "${value.day.toString().padLeft(2,'0')}/"
        "${value.month.toString().padLeft(2,'0')}/"
        "${value.year}";
  }
  if (value is Timestamp) {
    final dt = value.toDate();
    return "${dt.day.toString().padLeft(2,'0')}/"
        "${dt.month.toString().padLeft(2,'0')}/"
        "${dt.year}";
  }
  return value.toString();
}

