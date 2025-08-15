import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/account/competition_inscrites/competition_Register.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';

import '../../common/widgets/images/image_fond_ecran.dart';

class CompteAdherentView extends StatefulWidget {
  final String adherentId;

  const CompteAdherentView({required this.adherentId, super.key});

  @override
  State<CompteAdherentView> createState() => _CompteAdherentViewState();
}

class _CompteAdherentViewState extends State<CompteAdherentView> {
  Map<String, dynamic>? adherentData;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadAdherentData();
  }

  Future<void> _loadAdherentData() async {
    try {
      debugPrint("Tentative de récupération du document avec ID: ${widget.adherentId}");

      final doc = await FirebaseFirestore.instance
          .collection('adherents')
          .doc(widget.adherentId)
          .get();

      debugPrint("Document existe ? ${doc.exists}");
      debugPrint("Données du document: ${doc.data()}");

      if (!mounted) return;

      setState(() {
        if (doc.exists) {
          adherentData = doc.data();
        } else {
          error = 'Document introuvable dans Firestore';
        }
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Erreur Firebase: $e");
      if (!mounted) return;
      setState(() {
        error = 'Erreur de connexion à Firestore';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("CompteAdherentView build() appelé");

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(child: Text(error!)),
      );
    }

    if (adherentData == null) {
      return const Scaffold(
        body: Center(child: Text('Aucune donnée disponible')),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(title: ''),
      drawer: MediaQuery.sizeOf(context).width > 750 ? null : CustomDrawer(),
      body: Container(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Bonjour ${adherentData!['lastName']}',
                    style: titleStyleMedium(context),
                  ),
                  const SizedBox(height: 50),

                  _buildUserInfoSection(),
                  const SizedBox(height: 75),

                  CompetitionRegister(adherentId: '${adherentData!['id']}', competitionId: '')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Center(
      child: Column(
        children: [
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: [
              _buildInfoItem('Nom', adherentData!['lastName']),
              _buildInfoItem('Prénom', adherentData!['firstName']),
              _buildInfoItem('Email', adherentData!['email']),
            ],
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: [
              _buildInfoItem('Adresse', adherentData!['address']),
              _buildInfoItem('Téléphone', adherentData!['phone']),
            ],
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: [
              _buildInfoItem('Catégorie', adherentData!['category']),
              _buildInfoItem('Discipline', adherentData!['discipline']),
              _buildInfoItem('Ceinture', adherentData!['belt']),
              _buildInfoItem('N° de licence', adherentData!['licence']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String? value) {
    return Text(
      '$label: ${value ?? 'Non disponible'}',
      style: textStyleText(context),
    );
  }


  }
