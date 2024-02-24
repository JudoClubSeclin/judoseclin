import 'package:judoseclin/data/repository/user_repository/user_repository.dart';

class FetchUserDataUseCase {
  final UsersRepository usersRepository;
  final String userId;

  FetchUserDataUseCase(this.usersRepository, this.userId);

  Future<Map<String, dynamic>> invoke() async {
    try {
      return await usersRepository.fetchUserData(userId);
    } catch (e) {
      // Gérer l'erreur selon les besoins
      print("Erreur lors de la récupération des données utilisateur: $e");
      throw e; // Vous pouvez choisir de relancer l'erreur ou de retourner une valeur par défaut
    }
  }

  Future<void> checkAuthenticationStatus() async {
    await usersRepository.checkAuthenticationStatus();
  }
}
