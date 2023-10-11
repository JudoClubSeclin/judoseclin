import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:judoseclin/main.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final User? currentUser = auth.currentUser;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  _fetchUserData() async {
    if (currentUser != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser!.uid)
          .get();
      setState(() {
        userData = snapshot.data() as Map<String, dynamic>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = currentUser?.email ?? 'Adresse email non trouvée';

    return ListView(children: [
      ListTile(
        title: const Text('Adresse email',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        subtitle: Text(userEmail, style: const TextStyle(fontSize: 20)),
      ),
      if (userData != null) ...[
        GetUserData(userData!, 'date de naissance', 'Date de naissance'),
        GetUserData(userData!, 'nom', 'Nom'),
        GetUserData(userData!, 'prenom', 'Prénom'),
      ],
    ]);
  }
}

class GetUserData extends StatelessWidget {
  final Map<String, dynamic> userData;
  final String fieldName;
  final String fieldTitle;

  const GetUserData(this.userData, this.fieldName, this.fieldTitle, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayValue;
    if (userData.containsKey(fieldName)) {
      var value = userData[fieldName];
      if (value is Timestamp) {
        DateTime date = value.toDate();
        displayValue = "${date.day}/${date.month}/${date.year}";
      } else {
        displayValue = value.toString();
      }
      return ListTile(
        title: Text(
          fieldTitle,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        subtitle: Text(
          displayValue,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
      );
    } else {
      return ListTile(
        title: const Text(
          'Champ non trouvé',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
        subtitle: Text(
          fieldTitle,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
      );
    }
  }
}
