import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../../core/utils/competition_provider.dart';
import '../../../core/utils/competition_registration_provider.dart';

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

  List<Map<String, dynamic>> pastCompetitions = [];
  List<Map<String, dynamic>> futureCompetitions = [];

  final competitionProvider = CompetitionProvider();
  final registrationProvider = CompetitionRegistrationProvider();

  @override
  void initState() {
    super.initState();
    _loadAdherentData();
  }

  Future<void> _loadAdherentData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('adherents')
          .doc(widget.adherentId)
          .get();

      if (!mounted) return;

      if (doc.exists) {
        adherentData = doc.data();
        await _loadCompetitions();
      } else {
        error = 'Document introuvable dans Firestore';
      }
    } catch (e) {
      debugPrint("Erreur Firebase: $e");
      error = 'Erreur de connexion à Firestore';
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _loadCompetitions() async {
    if (adherentData == null) return;

    final adherentId = widget.adherentId;

    try {
      final allCompetitionIds = await registrationProvider
          .getUserInscriptionsForAdherent(adherentId);

      pastCompetitions.clear();
      futureCompetitions.clear();

      for (final compId in allCompetitionIds) {
        final compDoc = await FirebaseFirestore.instance
            .collection('competition')
            .doc(compId)
            .get();

        if (!compDoc.exists) continue;

        final data = compDoc.data()!;
        final rawDate = data['date'];

        DateTime compDate;
        if (rawDate is Timestamp) {
          compDate = rawDate.toDate();
        } else if (rawDate is String) {
          compDate = DateTime.tryParse(rawDate) ?? DateTime(1900);
        } else {
          continue; // type inattendu
        }

        final entry = {
          'id': compDoc.id,
          'title': (data['title'] ?? 'Compétition').toString(),
        };

        if (compDate.isBefore(DateTime.now())) {
          pastCompetitions.add(entry);
        } else {
          futureCompetitions.add(entry);
        }
      }

      if (mounted) setState(() {});
    } catch (e) {
      debugPrint("Erreur récupération compétitions : $e");
    }
  }

  Widget buildCompetitionCard(Map<String, dynamic> competition,
      {bool isPast = false}) {
    final title = competition['title'] ?? 'Compétition';
    final text = isPast
        ? 'J’ai participé à la compétition : $title'
        : 'Je suis inscrit à la compétition : $title';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: textStyleText(context),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    if (adherentData == null) return const SizedBox.shrink();

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
            ],
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: [
              _buildInfoItem('Poste occupé', adherentData!['boardPosition']),
              _buildInfoItem('N° de licence', adherentData!['licence']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, dynamic value) {
    return Text(
      '$label: ${value?.toString() ?? 'Non disponible'}',
      style: textStyleText(context),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      appBar: const CustomAppBar(title: ''),
      drawer:
      MediaQuery.of(context).size.width <= 750 ? const CustomDrawer() : null,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageFondEcran.imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Bonjour ${adherentData?['lastName']?.toString() ?? ''}',
                  style: titleStyleMedium(context),
                ),
                const SizedBox(height: 50),
                _buildUserInfoSection(),
                const SizedBox(height: 40),

                // 🔹 Compétitions futures
                Text("Compétitions à venir : ",
                    style: textStyleText(context)),
                if (futureCompetitions.isEmpty)
                  Text("Aucune compétition à venir.",
                      style: textStyleText(context)),
                ...futureCompetitions
                    .map((c) => buildCompetitionCard(c, isPast: false)),

                const SizedBox(height: 20),

                // 🔹 Compétitions passées
                Text("Compétitions passées : ",
                    style: textStyleText(context)),
                if (pastCompetitions.isEmpty)
                  Text("Aucune compétition passée.",
                      style: textStyleText(context)),
                ...pastCompetitions
                    .map((c) => buildCompetitionCard(c, isPast: true)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
