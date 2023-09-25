import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/main.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final User? currentUser = auth.currentUser;
  String userEmail = 'En cours de chargement';

  @override
  initState() {
    super.initState();
    if (currentUser!.email != null) {
      userEmail = currentUser!.email!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text(
            'Adresse email',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            userEmail,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        GetUserData(currentUser!.uid, 'Nom', 'nom'),
        GetUserData(currentUser!.uid, 'Prénom', 'prenom'),
        GetUserData(currentUser!.uid, 'Date de naissance', 'date de naissance'),
        GetUserData(currentUser!.uid, 'Licence', 'licence'),
      ],
    );
  }
}

class GetUserData extends StatelessWidget {
  final String documentId;
  final String fieldName;
  final String fieldTitle;
  const GetUserData(this.documentId, this.fieldName, this.fieldTitle,
      {super.key});
  @override
  Widget build(BuildContext context) {
    CollectionReference users = firestore.collection('Users');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const ListTile(
              title: Text(
            'Un problème est survenu',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return ListTile(
            title: Text(
              data[fieldTitle],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            subtitle: Text(
              fieldName,
              style: const TextStyle(fontSize: 20),
            ),
          );
        }
        return const ListTile(
            title: Text(
          'En cours de chargement',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ));
      },
    );
  }
}
