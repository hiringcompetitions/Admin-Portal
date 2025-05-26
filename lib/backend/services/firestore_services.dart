import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hiring_competitions_admin_portal/backend/models/user_model.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import 'package:hiring_competitions_admin_portal/constants/error_formatter.dart';

class FirestoreServices {
  // instance
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add Admin User
  Future<String?> addUser(UserModel user, String uid) async {
    try {
      await _firestore.collection("AdminUsers").doc(uid).set(user.get());
      return null;
    } on FirebaseException catch(e) {
      return ErrorFormatter().getFirestoreErrorMessage(e);
    }
  }

  // Get admin user status
  Future<DocumentSnapshot?> getAdminStatus(String uid) async {
    try {
      return await _firestore.collection("AdminUsers").doc(uid).get();
    } on FirebaseException catch(e) {
      final err = ErrorFormatter().getFirestoreErrorMessage(e);
      print(err);
      return null;
    }
  }

  // Get Users
  Stream<QuerySnapshot> getUsers() {
    return _firestore.collection("Users").snapshots();
  }

  // Get Admin Users
  Stream<QuerySnapshot> getAdminUsers() {
    return _firestore.collection("AdminUsers").snapshots();
  }

  // Reject Admin User Request
  Future<String ?> updateStatus(String email, String status) async {
    try {
      final querySnapshot = await _firestore
                        .collection("AdminUsers")
                        .where('email', isEqualTo: email)
                        .get();
      
      for(var doc in querySnapshot.docs) {
        await doc.reference.update({'pending' : status});
      }
      return null;
    } catch(e) {
      print(e.toString());
      return "Unable to reject the request. Please try again later";
    }
  }
}