import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/theme.dart';
import 'package:judoseclin/ui/common/widgets/appbar/custom_appbar.dart';

import '../../common/widgets/images/image_fond_ecran.dart';
import '../competition_inscrites/competition_inscrite.dart';

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
      debugPrint(
          "Tentative de récupération du document avec ID: ${widget.adherentId}");

      final doc = await FirebaseFirestore.instance
          .collection('adherents')
          .doc(widget.adherentId)
          .get();

      debugPrint("Document existe ? ${doc.exists}");
      debugPrint("Données du document: ${doc.data()}");

      if (!mounted) return;

      if (doc.exists) {
        setState(() {
          adherentData = doc.data();
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Document introuvable dans Firestore';
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Erreur Firebase: ${e.toString()}");
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
       appBar: CustomAppBar(title: '',),
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
                            // Le titre en haut
                            Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                'Bonjour ${adherentData!['lastName']}',
                                style: titleStyleMedium(context),
                              ),
                            ),
                            const SizedBox(height: 50),

                            // Infos centrées
                            Center(
                              child: Column(children: [
                                Wrap(children: [
                                  Text(
                                      'Nom: ${adherentData!['lastName'] ?? 'Non disponible'}',
                                      style: textStyleText(context)),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                      'Prénom: ${adherentData!['firstName'] ?? 'Non disponible'}',
                                      style: textStyleText(context)),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                      'Email: ${adherentData!['email'] ?? 'Non disponible'}',
                                      style: textStyleText(context)),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ]),
                                Wrap(
                                  children: [
                                    Text(
                                        'Adresse: ${adherentData!['address'] ?? 'Non disponible'}',
                                        style: textStyleText(context)),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                        'Téléphone: ${adherentData!['phone'] ?? 'Non disponible'}',
                                        style: textStyleText(context)),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                                Wrap(children: [
                                  Text(
                                      'Catégorie: ${adherentData!['category'] ?? 'Non disponible'}',
                                      style: textStyleText(context)),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                      'Discipline: ${adherentData!['discipline'] ?? 'Non disponible'}',
                                      style: textStyleText(context)),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                      'Ceinture: ${adherentData!['belt'] ?? 'Non disponible'}',
                                      style: textStyleText(context)),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                      'N° de licence: ${adherentData!['licence'] ?? 'Non disponible'}',
                                      style: textStyleText(context)),
                                ]),
                              ]),
                            ),

                            const SizedBox(
                              height: 75,
                            ),
                            const CompetitionsInscrites(),
                          ]),
                    )))));
  }
}
