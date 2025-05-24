import 'package:flutter/material.dart';
import 'package:hiring_competitions_admin_portal/backend/models/user_model.dart';
import 'package:hiring_competitions_admin_portal/backend/services/firestore_services.dart';

class FirestoreProvider extends ChangeNotifier {
  // instance
  FirestoreServices _services = FirestoreServices();

  bool _isLoading = false;
  bool? get isLoading => _isLoading;

  // add user
  Future<String?> addUser(UserModel user) async {
    try {
      _isLoading = true;
      notifyListeners();
      final res = await _services.addUser(user);
      _isLoading = false;
      notifyListeners();
      return res;
    } catch(e) {
      _isLoading = false;
      notifyListeners();
      return "An Unexpected error occured. Please try again later";
    }
  }
}