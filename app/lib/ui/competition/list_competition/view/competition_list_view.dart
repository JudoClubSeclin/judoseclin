import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListCompetition extends StatelessWidget {
  const ListCompetition({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('competitions')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Erreur de chargement'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Aucune compétition trouvée'));
        }

        final competitions = snapshot.data!.docs;

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: competitions.length,
          itemBuilder: (context, index) {
            final competition =
            competitions[index].data() as Map<String, dynamic>;

            final title = competition['title'] ?? 'Compétition sans titre';

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          },
        );
      },
    );
  }
}
