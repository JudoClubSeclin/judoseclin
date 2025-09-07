import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/ui/account/donnees_user/donnees_user.dart';

import '../../../theme.dart';
import '../../common/widgets/images/image_fond_ecran.dart';

class AccountView extends StatefulWidget {
  final Map<String, dynamic> userData;

  const AccountView({super.key, required this.userData});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late Future<List<Adherents>> _adherentsFuture;

  @override
  void initState() {
    super.initState();
    _adherentsFuture = _fetchFamilyMembers(widget.userData['familyId'] ?? '');
  }

  Future<List<Adherents>> _fetchFamilyMembers(String familyId) async {
    if (familyId.isEmpty) return [];

    final snapshot = await FirebaseFirestore.instance
        .collection('adherents')
        .where('familyId', isEqualTo: familyId)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Adherents(
        id: doc.id, // ✅ Firestore doc.id toujours présent
        lastName: data['lastName'] ?? '',
        firstName: data['firstName'] ?? '',
        familyId: data['familyId'] ?? '',
        dateOfBirth: data['dateOfBirth'],
        belt: data['belt'] ?? '',
        email: data['email'] ?? '',
        licence: data['licence'] ?? '',
        discipline: data['discipline'] ?? '',
        boardPosition: data['boardPosition'] ?? '',
        tutor: data['tutor'] ?? '',
        category: data['category'] ?? '',
        phone: data['phone'] ?? '',
        address: data['address'] ?? '',
        image: data['image'] ?? '',
        sante: data['sante'] ?? '',
        medicalCertificate: data['medicalCertificate'] ?? '',
        invoice: data['invoice'] ?? '',
        additionalAddress: data['additionalAddress'] ?? '',
        postalCode: data['postalCode'] ?? '',
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageFondEcran.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Adherents>>(
          future: _adherentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            }

            final adherents = snapshot.data ?? [];

            // ✅ Fallback sur utilisateurPrincipal
            if (adherents.isEmpty) {
              final utilisateurPrincipal = Adherents(
                id: widget.userData['id']?.toString() ?? 'fallback-id', // ✅ Jamais vide
                lastName: widget.userData['lastName'] ?? '',
                firstName: widget.userData['firstName'] ?? '',
                familyId: widget.userData['familyId'] ?? '',
                dateOfBirth: widget.userData['dateOfBirth'],
                belt: widget.userData['belt'] ?? '',
                email: widget.userData['email'] ?? '',
                licence: widget.userData['licence'] ?? '',
                discipline: widget.userData['discipline'] ?? '',
                boardPosition: widget.userData['boardPosition'] ?? '',
                tutor: widget.userData['tutor'] ?? '',
                category: widget.userData['category'] ?? '',
                phone: widget.userData['phone'] ?? '',
                address: widget.userData['address'] ?? '',
                image: widget.userData['image'] ?? '',
                sante: widget.userData['sante'] ?? '',
                medicalCertificate: widget.userData['medicalCertificate'] ?? '',
                invoice: widget.userData['invoice'] ?? '',
                additionalAddress: widget.userData['additionalAddress'] ?? '',
                postalCode: widget.userData['postalCode'] ?? '',
              );
              adherents.add(utilisateurPrincipal);
            }

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text('Bonjour la famille',
                          style: titleStyleMedium(context)),
                      const SizedBox(width: 22),
                      Text(adherents.first.firstName,
                          style: titleStyleMedium(context)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DonneesUser(
                    utilisateurPrincipal: adherents.first,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
