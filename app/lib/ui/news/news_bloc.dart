import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:judoseclin/ui/news/news_state.dart';
import 'package:judoseclin/ui/news/news_event.dart';
import 'package:judoseclin/ui/news/news_interactor.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsInteractor newsInteractor;
  final String newsId;
  final FirestoreService _service;

  NewsBloc(
      this._service,
      this.newsInteractor, {
        required this.newsId,
      }) : super(NewsInitialState()) {
    on<AddNewsSignUpEvent>(_onAddNewsSignUp);
  }

  Future<void> _onAddNewsSignUp(
      AddNewsSignUpEvent event,
      Emitter<NewsState> emit,
      ) async {
    emit(NewsLoadingState());

    try {
      if (event.titre.isEmpty) {
        emit(NewsErrorState("Le titre est requis."));
        return;
      }

      DocumentReference newsRef = await _service
          .collection("news")
          .add({
        'titre': event.titre,
        'contenu': event.contenu,
        'date_publication': event.publication
      });

      emit(NewsSuccessState(newsId: newsRef.id));
    } catch (e) {
      emit(NewsErrorState("Erreur lors de l'ajout de news: ${e.toString()}"));
    }
  }
}
