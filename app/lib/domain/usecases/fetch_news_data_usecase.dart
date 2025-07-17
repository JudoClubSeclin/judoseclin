
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/data/repository/news_repository.dart';
import 'package:judoseclin/domain/entities/news.dart';

import '../../core/di/injection.dart';


@injectable
class FetchNewsDataUseCase {
  final newsRepository = getIt<NewsRepository>();

  FetchNewsDataUseCase();

  Future<Iterable<News>> getNewsStream() async {
    try {
      debugPrint("Fetching news data");
      Stream<Iterable<News>> newsStream =
          newsRepository.getNewsStream();
      return await newsStream.first;
    }catch (e) {
      debugPrint('Error fetching news date: $e');
      return[];
    }
  }

  Future<News?> getNewsById(String newsId) async {
    try {
      debugPrint("Fetching news data...");
      final docSnapshot = await newsRepository.getById(newsId);
      if (docSnapshot == null || !docSnapshot.exists) return null;
      return News.fromFirestore(docSnapshot, newsId);
    } catch (e) {
      debugPrint("Error fetching news by ID: $e");
      rethrow;
    }
  }


}