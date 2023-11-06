import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/competition.dart';
import '../interactor/competition_interactor.dart';
import 'competition_event.dart';
import 'competition_state.dart';

class CompetitionBloc extends Bloc<CompetitionEvent, CompetitionState> {
  final CompetitionInteractor competitionInteractor;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CompetitionBloc(this.competitionInteractor) : super(CompetitionLoading());

  @override
  Stream<CompetitionState> mapEventToState(CompetitionEvent event) async* {
    if (event is LoadCompetitions) {
      yield CompetitionLoading();
      try {
        final competitions = await competitionInteractor.fetchCompetitionData();
        yield CompetitionLoaded(competitionData: competitions);
      } catch (e) {
        yield CompetitionError(message: 'Une erreur s\'est produite : $e');
      }
    }
  }

  Future<Competition?> getCompetitionById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await firestore.collection('competitions').doc(id).get();
      if (doc.exists) {
        return Competition.fromFirestore(doc as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint(e as String?);
    }
    return null;
  }
}
