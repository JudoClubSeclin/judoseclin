import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:judoseclin/firebase_options.dart';
import 'package:judoseclin/root.dart';
import 'package:judoseclin/ui/common/competition_info/Cubit/competition_cubit.dart';
import 'package:judoseclin/ui/common/competition_info/Cubit/inscription-competition_cubit.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
void main() {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<CompetitionCubit>(
            create: (context) => CompetitionCubit(),
          ),
          BlocProvider<InscriptionCompetitionCubit>(
            create: (context) => InscriptionCompetitionCubit(_firestore),
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Root(),
        ),
      ),
    );
  });
}
