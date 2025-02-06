import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:judoseclin/ui/members/interactor/users_interactor.dart';
import 'package:judoseclin/ui/members/login/user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UsersInteractor usersInteractor;
  String? userId; // Peut être null au départ

  UserBloc(this.usersInteractor) : super(UserInitial()) {
    on<FetchUserDataEvent>((event, emit) async {
      // Vérifier s'il y a un utilisateur connecté
      userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        emit(AuthenticationErrorState());
        return;
      }

      try {
        Map<String, dynamic> userData =
        await usersInteractor.fetchUserData(userId!);
        emit(UserDataLoadedState(userData));
      } catch (e) {
        emit(AuthenticationErrorState());
      }
    });

    on<LoginWithEmailPassword>((event, emit) async {
      emit(UserLoading());
      try {
        await usersInteractor.login(event.email, event.password);

        // Récupération de l'userId après connexion
        userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId == null) {
          emit(AuthenticationErrorState());
          return;
        }

        Map<String, dynamic> userData =
        await usersInteractor.fetchUserData(userId!);
        emit(UserDataLoadedState(userData));

        // Rediriger vers /account après connexion
        event.navigateToAccount();
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });

    on<LogOutEvent>((event, emit) async {
      try {
        await usersInteractor.logOut();
        userId = null; // Réinitialiser après déconnexion
        emit(UserInitial());
      } catch (error) {
        emit(AuthenticationErrorState());
      }
    });
  }
}
