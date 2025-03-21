import 'package:flutter/material.dart';
import 'package:judoseclin/ui/account/competition_inscrites/competition_inscrite.dart';
import 'package:judoseclin/ui/account/donnees_user/donnees_user.dart';

import '../../../theme.dart';
import '../../common/widgets/images/image_fond_ecran.dart';

class AccountView extends StatelessWidget {
  final Map<String, dynamic> userData;

  const AccountView({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Bonjour', style: titleStyleMedium(context)),
                    const SizedBox(width: 15),
                    Text(
                      userData['lastName'] ?? 'Not available',
                      style: titleStyleMedium(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                DonneesUser(),
                const SizedBox(height: 55),
                const CompetitionsInscrites(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
