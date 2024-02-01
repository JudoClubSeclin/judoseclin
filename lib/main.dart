import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:judoseclin/domain/usecases/competitions/fetch_add_comptetition_data_usecase.dart';
import 'package:judoseclin/domain/usecases/competitions/fetch_competitions_data_usecase.dart';
import 'package:judoseclin/domain/usecases/cotisation/fetch_cotisation_data_usecase.dart';
import 'package:judoseclin/firebase_options.dart';
import 'package:judoseclin/ui/common/account/bloc/account_bloc.dart';
import 'package:judoseclin/ui/common/account/interactor/account_interactor.dart';
import 'package:judoseclin/ui/common/adherents/bloc/adherents_bloc.dart';
import 'package:judoseclin/ui/common/adherents/bloc/adherents_event.dart';
import 'package:judoseclin/ui/common/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/common/adherents/view/add_adherents_view.dart';
import 'package:judoseclin/ui/common/competition/add_competition/bloc/add_competition_bloc.dart';
import 'package:judoseclin/ui/common/competition/add_competition/bloc/add_competition_event.dart';
import 'package:judoseclin/ui/common/competition/add_competition/interactor/add_competition_interactor.dart';
import 'package:judoseclin/ui/common/competition/add_competition/view/add_competition_view.dart';
import 'package:judoseclin/ui/common/competition/inscription_competition/bloc/inscription_competition_bloc.dart';
import 'package:judoseclin/ui/common/competition/list_competition/bloc/competition_bloc.dart';
import 'package:judoseclin/ui/common/competition/list_competition/interactor/competition_interactor.dart';
import 'package:judoseclin/ui/common/cotisations/bloc/cotisation_bloc.dart';
import 'package:judoseclin/ui/common/cotisations/interactor/cotisation_interactor.dart';
import 'package:judoseclin/ui/common/cotisations/view/add_cotisation_view.dart';
import 'package:judoseclin/ui/common/members/inscription/bloc/inscription_bloc.dart';
import 'package:judoseclin/ui/common/members/inscription/interactor/inscription_interactor.dart';
import 'package:judoseclin/ui/common/members/login/bloc/login_bloc.dart';
import 'package:judoseclin/ui/common/members/login/interactor/login_interactor.dart';
import 'package:judoseclin/ui/common/routes/router_config.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';

import 'domain/usecases/adherents/fetch_adherents_data_usecase.dart';

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
            BlocProvider<AdherentsBloc>(
              create: (context) {
                var fetchAdherentsDataUseCase = FetchAdherentsDataUseCase();
                var firestore = FirebaseFirestore.instance;

                var interactor =
                    AdherentsInteractor(fetchAdherentsDataUseCase, firestore);
                var adherentsBloc = AdherentsBloc(interactor, adherentId: '');

                // Attach event handlers
                adherentsBloc.on<SignUpEvent>((event, emit) {
                  // Implement event handling logic here
                });

                return adherentsBloc;
              },
              child: AddAdherentsView(),
            ),
            BlocProvider(
              create: (context) {
                var fetchCotisationDataUseCase = FetchCotisationDataUseCase();
                var cotisationInteractor = CotisationInteractor(
                  fetchCotisationDataUseCase,
                  FirebaseFirestore.instance,
                );

                return CotisationBloc(
                  cotisationInteractor: cotisationInteractor,
                  adherentId: '',
                );
              },
              child: AddCotisationView(
                adherentId: '',
              ),
            ),
            BlocProvider<AddCompetitionBloc>(
              create: (context) {
                var fetchAddCompetitionDataUseCase =
                    FetchAddCompetitionDataUseCase();
                var firestore = FirebaseFirestore.instance;
                var interactor = AddCompetitionInteractor(
                    fetchAddCompetitionDataUseCase, firestore);
                var addCompetitionBloc = AddCompetitionBloc(interactor);
                //attach event handlers
                addCompetitionBloc
                    .on<AddCompetitionSignUpEvent>((event, emit) {});
                return addCompetitionBloc;
              },
              child: const AddCompetitionView(publishDate: null),
            )
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
