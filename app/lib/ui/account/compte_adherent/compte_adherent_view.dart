import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';
import 'package:judoseclin/ui/common/widgets/images/image_fond_ecran.dart';

import '../../../core/utils/competition_provider.dart';
import '../../../core/utils/competition_registration_provider.dart';
import '../../../core/utils/envoyer_email_invitation.dart';

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
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _loadCompetitions() async {
    if (adherentData == null) return;

    final adherentId = widget.adherentId;

    try {
      // 1) Récupère tous les competitionId pour cet adhérent
      final allCompetitionIds = await registrationProvider
          .getUserInscriptionsForAdherent(adherentId); // lit 'competition_registration'

      pastCompetitions.clear();
      futureCompetitions.clear();

      for (final compId in allCompetitionIds) {
        // 2) Charge la compétition dans la collec 'competition' (singulier)
        final compDoc = await FirebaseFirestore.instance
            .collection('competition')
            .doc(compId)
            .get();

        if (!compDoc.exists) continue;

        final data = compDoc.data()!;
        // 3) Date robuste (Timestamp ou String)
        final rawDate = data['date'];
        DateTime compDate;
        if (rawDate is Timestamp) {
          compDate = rawDate.toDate();
        } else if (rawDate is String) {
          compDate = DateTime.tryParse(rawDate) ?? DateTime(1900);
        } else {
          // type inattendu -> on ignore
          continue;
        }

        final entry = {
          'id': compDoc.id,
          'title': (data['title'] ?? 'Compétition') as String,
        };

        if (compDate.isBefore(DateTime.now())) {
          pastCompetitions.add(entry);
        } else {
          futureCompetitions.add(entry);
        }
      }

      if (mounted) setState(() {}); // rafraîchir l’UI si on a rempli les listes
    } catch (e) {
      debugPrint("Erreur récupération compétitions : $e");
    }
  }



  Widget buildCompetitionCard(Map<String, dynamic> competition, {bool isPast = false}) {
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
      appBar: CustomAppBar(title: ''),
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
                  'Bonjour ${adherentData!['lastName']}',
                  style: titleStyleMedium(context),
                ),
                const SizedBox(height: 50),
                _buildUserInfoSection(),
                const SizedBox(height: 40),

                // 🔹 Compétitions futures
                 Text("Compétitions à venir : ", style: textStyleText(context)),
                if (futureCompetitions.isEmpty)  Text("Aucune compétition à venir.",style: textStyleText(context)),
                ...futureCompetitions.map((c) => buildCompetitionCard(c, isPast: false)),

                const SizedBox(height: 20),

                // 🔹 Compétitions passées
                 Text("Compétitions passées : ", style: textStyleText(context)),
                if (pastCompetitions.isEmpty)  Text("Aucune compétition passée.", style: textStyleText(context)),
                ...pastCompetitions.map((c) => buildCompetitionCard(c, isPast: true)),

                ElevatedButton(
                  onPressed: () async {
                    if (adherentData != null) {
                      debugPrint('Envoi email à: ${adherentData!['email']}');
                      debugPrint('Nom: ${adherentData!['firstName']}');
                      debugPrint('Prénom: ${adherentData!['lastName']}');
                      final success = await envoyerEmailInvitation(

                        email: adherentData!['email'] ?? '',
                        nom: adherentData!['lastName'] ?? '',
                        prenom: adherentData!['firstName'] ?? '',
                      );

                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'E-mail envoyé avec succès !',
                              style: textStyleText(context),
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Erreur lors de l\'envoi de l\'e-mail',
                              style: textStyleText(context),
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Envoyer email test"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
