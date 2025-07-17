
import 'package:flutter/material.dart';
import 'package:judoseclin/data/repository/news_repository.dart';
import 'package:judoseclin/domain/entities/news.dart';
import 'package:judoseclin/domain/usecases/fetch_news_data_usecase.dart';

class NewsInteractor {
  final FetchNewsDataUseCase fetchNewsDataUseCase;
  final NewsRepository newsRepository;

  NewsInteractor(this.fetchNewsDataUseCase, this.newsRepository);

  Future<void> addNews(News news) async {
    try {
      await newsRepository.addNews({
        'titre': news.titre,
        'contenu': news.contenu,
        'date_publication': news.publication,
      });
    }catch(e) {
      debugPrint("Erreur lors de l'ajout news: $e");
    }
  }

  Future<Iterable<News>> fetchNewsData() async {
    try {
      return await fetchNewsDataUseCase.getNewsStream();
    }catch(e){
      rethrow;
    }
  }

  Future<News?> getNewsById(String newsId) async {
    try {
      return await fetchNewsDataUseCase.getNewsById(newsId);
    }catch(e) {
      rethrow;
    }
  }

  Future<void> updateNewsField({
    required String newsId,
    required String fieldName,
    required String newValue
}) async {
    try {
      await newsRepository.updateNews(newsId, fieldName, newValue);
    }catch(e) {
      rethrow;
    }
  }
}