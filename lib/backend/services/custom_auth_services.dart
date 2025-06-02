import 'package:firebase_auth/firebase_auth.dart';
import 'package:hiring_competitions_admin_portal/constants/error_formatter.dart';

class CustomAuthServices {
  // Instance
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Login
  
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return {"res" : userCredential.user};
    } on FirebaseAuthException catch(e) {
      String err = ErrorFormatter().getFirebaseAuthErrorMessage(e);
      return {"res" : err};
    }
  }

  // Create Account

  Future<Map<String, dynamic>> signup(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return {"res" : userCredential.user};
    } on FirebaseAuthException catch(e) {
      String err = ErrorFormatter().getFirebaseAuthErrorMessage(e);
      return {"res" : err};
    }
  }

  // Signout
  Future<void> logout() async {
    await _auth.signOut();
  }
}