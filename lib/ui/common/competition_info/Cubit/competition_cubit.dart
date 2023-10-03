import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/ui/common/competition_info/model/competition.dart';

class CompetitionCubit extends Cubit<List<Competition>> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CompetitionCubit() : super([]);

  void getCompetitions() async {
    try {
      QuerySnapshot snapshot = await firestore.collection('competition').get();
      List<Competition> competitions = snapshot.docs
          .map((doc) => Competition.fromFirestore(
              doc as DocumentSnapshot<Map<String, dynamic>>))
          .toList();
      emit(competitions);
    } catch (e) {
      // Handle errors accordingly. Maybe emit an error state.
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
