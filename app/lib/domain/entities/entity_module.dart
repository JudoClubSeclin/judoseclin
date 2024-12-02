

import 'package:get_it/get_it.dart';
import 'package:judoseclin/core/utils/parse_cheques.dart';
import 'package:judoseclin/domain/entities/adherents.dart';
import 'package:judoseclin/domain/entities/cotisation.dart';
import 'package:judoseclin/domain/entities/inscription_competition.dart';
import 'package:judoseclin/domain/entities/news.dart';
import 'package:judoseclin/domain/entities/users.dart';

import 'competition.dart';

final GetIt getIt = GetIt.instance;

void setupEntityModule() {

  ///enregistrement Adherents entity
  getIt.registerFactory<Adherents>(() => Adherents(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      dateOfBirth: null,
      licence: '',
      belt: '',
      discipline: '',
      category: '',
      tutor: '',
      phone: '',
      address: '',
      image: '',
      sante: '',
      medicalCertificate: '',
      invoice: ''
  ));

  ///enregistrement Competition entity
  getIt.registerFactory<Competition>(() => Competition(
      id: '',
      address: '',
      title: '',
      subtitle: '',
      date: null,
      publishDate: DateTime.now(),
      poussin: '',
      benjamin: '',
      minime: '',
      cadet: '',
      juniorSenior: ''
  ));

  ///Enregistrement cotisation entity
  getIt.registerFactory<Cotisation>(() => Cotisation(
      id: '',
      adherentId: '',
      amount:0 ,
      date: '',
      cheques: parseCheques('') ,
      bankName: ''
  ));

  ///Enregistrement inscription_competition entity
  getIt.registerFactory<InscriptionCompetition>(() => InscriptionCompetition(
      id: '',
      userId: '',
      competitionId: '',
      timestamp: null
  ));

  ///Enregistrement news entity
  getIt.registerFactory<News>(() => News(
      titre: '',
      datePublication: null,
      details: ''
  ));

  ///Enregistrement de Users entity
  getIt.registerFactory<Users>(() => Users(
      id: '',
      firstName: '',
      lastName: '',
      dateOfBirth: null,
      email: '',
      password: ''
  ));

}