

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:judoseclin/core/di/api/firestore_service.dart';
import 'package:judoseclin/data/repository/news_repository.dart';
import 'package:judoseclin/domain/entities/news.dart';

@injectable
class NewsRepositoryImpl implements NewsRepository {
  final FirestoreService _firestoreService;

  NewsRepositoryImpl(this._firestoreService);

  @override
  Future<void> addNews(Map<String, dynamic> data) async {
    try {
      await _firestoreService.collection("news").add(data);
    }catch (e) {
      debugPrint("Error adding news:  $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteNews(newsId) async {
await _firestoreService.collection("news").doc(newsId).delete();
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getById(String newsId) {
    return _firestoreService
        .collection("news")
        .doc(newsId)
        .get();
  }


  @override
  Stream<Iterable<News>> getNewsStream() {
    return _firestoreService
        .collection("news")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
        .map((doc) => News.fromFirestore(doc))
        .toList()
    );
  }




  @override
  Future<void> updateNews(String newsId, fieldName, newValue) async {
   try {
     await _firestoreService.collection("news").doc(newsId).update({
       fieldName: newValue
     });
   }catch (e) {
     debugPrint("Error updating field: $e");
     rethrow;
   }

  }

}