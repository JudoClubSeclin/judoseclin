import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FunctionAdminService extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  bool _isAdmin = false;
  bool _isInitialized = false;

  User? get user => _user;
  bool get isAdmin => _isAdmin;
  bool get isInitialized => _isInitialized;

  FunctionAdminService() { // <-- Correction ici
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _user = null;
      _isAdmin = false;
    } else {
      _user = firebaseUser;
      await _checkAdminStatus();
    }
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> _checkAdminStatus() async {
    if (_user != null) {
      try {
        final userDoc = await _firestore.collection('Users').doc(_user!.uid).get();
        _isAdmin = userDoc.data()?['admin'] == true;
      } catch (e) {
        debugPrint('Erreur lors de la vérification du statut admin: $e');
        _isAdmin = false;
      }
    } else {
      _isAdmin = false;
    }
  }

  Future<bool> hasAccess() async {
    if (!_isInitialized) {
      await Future.doWhile(() async {
        await Future.delayed(Duration(milliseconds: 100));
        return !_isInitialized;
      });
    }
    return _isAdmin;
  }
}
