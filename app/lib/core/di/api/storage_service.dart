import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StorageService {
  final FirebaseStorage _firebaseStorage;

  StorageService(this._firebaseStorage);

  Reference ref(String path) {
    return _firebaseStorage.ref(path);
  }

  Future<void> uploadFile(String path, File file) async {
    try {
      await _firebaseStorage.ref(path).putFile(file);
    } catch (e) {
      debugPrint('Error uploading file: $e');
      rethrow;
    }
  }

  Future<String> downloadUrl(String path) async {
    try {
      final ref = _firebaseStorage.ref(path);
      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint('Error fetching download URL: $e');
      rethrow;
    }
  }
}

