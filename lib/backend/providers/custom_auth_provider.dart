import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hiring_competitions_admin_portal/backend/services/custom_auth_services.dart';

class CustomAuthProvider extends ChangeNotifier {
  // Services Instance
  CustomAuthServices _authServices = CustomAuthServices();

  bool? _isloading = false;
  bool? get isLoading => _isloading;

  User? _user;
  User? get user => _user;


  // Login

  Future<String?> login(String email, String password) async {
    try {
      _isloading = true;
      notifyListeners();
      final user = await _authServices.login(email, password);

      if(user["res"] is User && user["res"] != null) {
        _user = user["res"];
        _isloading = false;
        notifyListeners();
        return null;
      }
      _isloading = false;
      notifyListeners();
      return user["res"];
    } catch(e) {
      _isloading = false;
      notifyListeners();
      return "Unexpected Error Occured. Please try again later";
    }
  }

  // Create account

  Future<String?> signup(String name, String email, String password) async {
    try {
      _isloading = true;
      notifyListeners();

      final response = await _authServices.signup(email, password);

      if(response["res"] is User && response["res"] != null) {
        User finalUser = response["res"];

        finalUser.updateDisplayName(name);
        finalUser.reload();

        _user = finalUser;
        _isloading = false;
        notifyListeners();
        return null;
      }

      _isloading = false;
      notifyListeners();
      return response["res"];
    } catch(e) {
      _isloading = false;
      notifyListeners();
      return "Unexpected Error occured. Please try again later";
    }
  }

  // Logout

  Future<String?> logout() async {
    try {
      await _authServices.logout();
      return null;
    } catch(e) {
      return "Unexpected error occured. Please try again later";
    }
  }

  // Check Login status

  Future<void> checkLogin() async {
    _user = FirebaseAuth.instance.currentUser;
    print(_user!.displayName);
    notifyListeners();
  }
}