import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hiring_competitions_admin_portal/backend/providers/firestore_provider.dart';
import 'package:hiring_competitions_admin_portal/backend/services/custom_auth_services.dart';

class CustomAuthProvider extends ChangeNotifier {
  // Services Instance
  CustomAuthServices _authServices = CustomAuthServices();

  bool? _isloading = false;
  bool? get isLoading => _isloading;

  User? _user;
  User? get user => _user;

  final FirestoreProvider firestoreProvider;

  CustomAuthProvider({required this.firestoreProvider});

  String? adminStatus;
  bool isInitialized = false;


  Future<void> fetchAdminStatus() async {
    final doc = await firestoreProvider.getAdminStatus(user!.uid);
    if (doc != null && doc.data() != null) {
      final data = doc.data() as Map<String, dynamic>;
      adminStatus = data['status'] ?? 'Pending';
    } else {
      adminStatus = 'Pending';
    }
  }



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
    
    _user = null;
    adminStatus = null;
    isInitialized = false;
    notifyListeners();

    return null;
  } catch(e) {
    return "Unexpected error occured. Please try again later";
  }
}


  // Check Login status

  Future<void> checkLogin() async {
    _user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await fetchAdminStatus();
    } else {
      adminStatus = null;
    }

    isInitialized = true;
    notifyListeners();
  }
}