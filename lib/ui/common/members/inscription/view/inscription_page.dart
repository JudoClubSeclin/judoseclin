import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/inscription_bloc.dart';
import '../interactor/inscription_interactor.dart';
import 'inscription_view.dart';

class InscriptionPage extends StatelessWidget {
  const InscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InscriptionBloc(
        InscriptionInteractor(
          auth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance,
        ),
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: InscriptionView(),
        ),
      ),
    );
  }
}
