import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:judoseclin/domain/entities/news.dart';

abstract class NewsRepository {
  Stream <Iterable<News>> getNewsStream();
  Future<DocumentSnapshot<Map<String, dynamic>>?> getById(String newsId);
  Future<void> addNews(Map<String, dynamic>data);
  Future<void> deleteNews (String newsId);
  Future<void> updateNews(
      String newsId, String fieldName, dynamic newValue
      );
}