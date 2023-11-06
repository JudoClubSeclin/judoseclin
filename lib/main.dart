import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:judoseclin/domain/usecases/competitions/fetch_competitions_data_usecase.dart';
import 'package:judoseclin/firebase_options.dart';
import 'package:judoseclin/ui/common/account/bloc/account_bloc.dart';
import 'package:judoseclin/ui/common/account/interactor/account_interactor.dart';
import 'package:judoseclin/ui/common/competition/inscription_competition/bloc/inscription_competition_bloc.dart';
import 'package:judoseclin/ui/common/competition/list_competition/bloc/competition_bloc.dart';
import 'package:judoseclin/ui/common/competition/list_competition/interactor/competition_interactor.dart';
import 'package:judoseclin/ui/common/members/inscription/bloc/inscription_bloc.dart';
import 'package:judoseclin/ui/common/members/inscription/interactor/inscription_interactor.dart';
import 'package:judoseclin/ui/common/members/login/bloc/login_bloc.dart';
import 'package:judoseclin/ui/common/members/login/interactor/login_interactor.dart';
import 'package:judoseclin/ui/common/routes/router_config.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';

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
            BlocProvider<CompetitionBloc>(
              create: (context) => CompetitionBloc(
                CompetitionInteractor(FetchCompetitionDataUseCase()),
              ),
            ),
            BlocProvider<InscriptionCompetitionBloc>(
              create: (context) => InscriptionCompetitionBloc(_firestore),
            ),
            BlocProvider<LoginBloc>(
              create: (context) =>
                  LoginBloc(loginInteractor: LoginInteractor()),
              lazy: false,
            ),
            BlocProvider<InscriptionBloc>(
              create: (context) => InscriptionBloc(InscriptionInteractor(
                auth: FirebaseAuth.instance,
                firestore: FirebaseFirestore.instance,
              )),
            ),
            BlocProvider<AccountBloc>(
              create: (context) =>
                  AccountBloc(accountInteractor: AccountInteractor()),
            ),
          ],
          child: Builder(builder: (BuildContext context) {
            return MaterialApp.router(
                theme: theme,
                routerConfig: goRouter,
                debugShowCheckedModeBanner: false);
          })),
    );
  });
}
