import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hiring_competitions_admin_portal/backend/models/user_model.dart';
import 'package:hiring_competitions_admin_portal/constants/error_formatter.dart';

class FirestoreServices {
  // instance
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add Admin User
  Future<String?> addUser(UserModel user) async {
    try {
      await _firestore.collection("AdminUsers").doc().set(user.get());
      return null;
    } on FirebaseException catch(e) {
      return ErrorFormatter().getFirestoreErrorMessage(e);
    }
  }
}