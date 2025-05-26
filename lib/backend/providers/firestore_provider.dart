import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hiring_competitions_admin_portal/backend/models/user_model.dart';
import 'package:hiring_competitions_admin_portal/backend/services/firestore_services.dart';

class FirestoreProvider extends ChangeNotifier {
  // instance
  FirestoreServices _services = FirestoreServices();

  bool? _isLoading = false;
  bool? get isLoading => _isLoading;

  // add user
  Future<String?> addUser(UserModel user, String uid) async {
    try {
      _isLoading = true;
      notifyListeners();
      final res = await _services.addUser(user, uid);
      _isLoading = false;
      notifyListeners();
      return res;
    } catch(e) {
      _isLoading = false;
      notifyListeners();
      return "An Unexpected error occured. Please try again later";
    }
  }

  // Get Admin User
  Future<DocumentSnapshot?> getAdminStatus(String uid) async {
    try {
      return await _services.getAdminStatus(uid);
    } on FirebaseException catch(e) {
      return null;
    }
  }

  // Get User
  Stream<QuerySnapshot> getUsers() {
    return _services.getUsers();
  }

  // Get Admin Users
  Stream<QuerySnapshot> getAdminUsers() {
    return _services.getAdminUsers();
  }

  // Delete Admin User
  Future<String?> updateStatus(String email, String status) async {
    try {
      final res = await _services.updateStatus(email, status);
      return res;
    } catch(e) {
      return "Unexpected error occured. Please try again later";
    }
  }
}