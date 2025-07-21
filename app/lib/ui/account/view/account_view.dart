import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/ui/account/donnees_user/donnees_user.dart';
import 'package:provider/provider.dart';

import '../../../core/utils/date_converter.dart';
import '../../../core/utils/function_admin.dart';
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
      dateOfBirth: DateConverter.convertToDateTime(userData['dateOfBirth']),
      belt: userData['belt'] ?? '',
      email: userData['email'] ?? '',
      licence: userData['licence'] ?? '',
      discipline: userData['discipline'] ?? '',
      category: userData['category'] ?? '',
      phone: userData['phone'] ?? '',
      address: userData['address'] ?? '',
      image: userData['image'] ?? '',
      sante: userData['sante'] ?? '',
      medicalCertificate: userData['medicalCertificate'] ?? '',
      invoice: userData['invoice'] ?? '',
    );

    final List<Adherents> adherents = [utilisateurPrincipal];

    return Scaffold(


    body:  Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageFondEcran.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
