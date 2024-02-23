import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:judoseclin/data/repository/user_repository/user_repository.dart';
import 'package:judoseclin/domain/usecases/competitions/fetch_competitions_data_usecase.dart';
import 'package:judoseclin/domain/usecases/cotisation/fetch_cotisation_data_usecase.dart';
import 'package:judoseclin/firebase_options.dart';
import 'package:judoseclin/ui/account/bloc/account_bloc.dart';
import 'package:judoseclin/ui/account/interactor/account_interactor.dart';
import 'package:judoseclin/ui/account/view/account_page.dart';
import 'package:judoseclin/ui/adherents/bloc/adherents_bloc.dart';
import 'package:judoseclin/ui/adherents/bloc/adherents_event.dart';
import 'package:judoseclin/ui/adherents/interactor/adherents_interactor.dart';
import 'package:judoseclin/ui/adherents/view/add_adherents_view.dart';
import 'package:judoseclin/ui/common/routes/router_config.dart';
import 'package:judoseclin/ui/common/theme/theme.dart';
import 'package:judoseclin/ui/competition/add_competition/bloc/add_competition_bloc.dart';
import 'package:judoseclin/ui/competition/add_competition/bloc/add_competition_event.dart';
import 'package:judoseclin/ui/competition/add_competition/view/add_competition_view.dart';
import 'package:judoseclin/ui/competition/inscription_competition/bloc/inscription_competition_bloc.dart';
import 'package:judoseclin/ui/competition/list_competition/bloc/competition_bloc.dart';
import 'package:judoseclin/ui/competition/list_competition/bloc/competition_event.dart';
import 'package:judoseclin/ui/competition/list_competition/interactor/competition_interactor.dart';
import 'package:judoseclin/ui/competition/list_competition/view/competition_list_view.dart';
import 'package:judoseclin/ui/cotisations/bloc/cotisation_bloc.dart';
import 'package:judoseclin/ui/cotisations/interactor/cotisation_interactor.dart';
import 'package:judoseclin/ui/cotisations/view/add_cotisation_view.dart';
import 'package:judoseclin/ui/members/inscription/bloc/inscription_bloc.dart';
import 'package:judoseclin/ui/members/interactor/users_interactor.dart';
import 'package:judoseclin/ui/members/login/bloc/user_bloc.dart';

import 'data/repository/adherents_repository/adherents_repository.dart';
import 'data/repository/competition_repository/competition_repository.dart';
import 'data/repository/cotisation_repository/cotisation_repository.dart';
import 'domain/usecases/adherents/fetch_adherents_data_usecase.dart';

FirebaseAuth auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

void main() {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<CompetitionBloc>(
              create: (context) {
                CompetitionRepository competitionRepository =
                    ConcretedCompetitionRepository();
                var fetchCompetitionDataUseCase =
                    FetchCompetitionDataUseCase(competitionRepository);
                var interactor = CompetitionInteractor(
                    fetchCompetitionDataUseCase, competitionRepository);

                // Passer interactor et competitionId lors de la création du CompetitionBloc
                var competitionBloc =
                    CompetitionBloc(interactor, competitionId: '');
                competitionBloc.on<CompetitionEvent>((event, emit) {});

                return competitionBloc;
              },
              child: const CompetitionsListView(),
            ),
            BlocProvider<InscriptionCompetitionBloc>(
              create: (context) => InscriptionCompetitionBloc(firestore),
            ),
            BlocProvider<UserBloc>(create: (context) {
              UsersRepository userRepository = ConcretedUserRepository();
              return UserBloc(UsersInteractor(userRepository: userRepository),
                  userId: '');
            }),
            BlocProvider<InscriptionBloc>(create: (context) {
              UsersRepository userRepository = ConcretedUserRepository();
              return InscriptionBloc(
                  UsersInteractor(userRepository: userRepository),
                  userId: '');
            }),
            BlocProvider<AccountBloc>(
              create: (context) {
                UsersRepository userRepository = ConcretedUserRepository();
                var userId = '';
                var accountInteractor =
                    AccountInteractor(userRepository, userId);
                return AccountBloc(
                    accountInteractor: accountInteractor, userId: userId);
              },
              child: const AccountPage(),
            ),
            BlocProvider<AdherentsBloc>(
              create: (context) {
                AdherentsRepository adherentsRepository =
                    ConcretedAdherentsRepository();
                var fetchAdherentsDataUseCase =
                    FetchAdherentsDataUseCase(adherentsRepository);
                var interactor = AdherentsInteractor(
                    fetchAdherentsDataUseCase, adherentsRepository);
                var adherentsBloc = AdherentsBloc(interactor, adherentId: '');

                // Attach event handlers
                adherentsBloc.on<AddAdherentsSignUpEvent>((event, emit) {
                  // Implement event handling logic here
                });
                return adherentsBloc;
              },
              child: AddAdherentsView(
                adherentsRepository: null,
              ),
            ),
            BlocProvider(
              create: (context) {
                CotisationRepository cotisationRepository =
                    ConcretedCotisationRepository();
                var fetchCotisationDataUseCase =
                    FetchCotisationDataUseCase(cotisationRepository);
                var cotisationInteractor = CotisationInteractor(
                    fetchCotisationDataUseCase, cotisationRepository);

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
                CompetitionRepository competitionRepository =
                    ConcretedCompetitionRepository();
                var fetchCompetitionDataUseCase =
                    FetchCompetitionDataUseCase(competitionRepository);
                var interactor = CompetitionInteractor(
                    fetchCompetitionDataUseCase, competitionRepository);
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
