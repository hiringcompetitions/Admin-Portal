import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hiring_competitions_admin_portal/backend/models/opportunity_model.dart';
import 'package:hiring_competitions_admin_portal/backend/models/user_model.dart';
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
      print("GET ADMIN STATUS : "+err.toString());
      return null;
    }
  }

  // Get Total Users
  Stream<QuerySnapshot> getUsers() {
    return _firestore.collection("Users").snapshots();
  }

  // Get Users by Batch
  Stream<QuerySnapshot> getUsersByBatch(String batch) {
    return _firestore.collection("Users").where("passedOutYear", isEqualTo: batch).snapshots();
  }

  // Get Batches
  Stream<QuerySnapshot> getBatches() {
    return _firestore.collection("Batches").snapshots();
  }

  // Add New Batch
  Future<String?> addNewBatch(int batch) async {
    try {
      await _firestore.collection("Batches").doc().set({"batch" : batch});
      return null;
    } catch(e) {
      return e.toString();
    }
  }

  // Get Admin Users
  Stream<QuerySnapshot> getAdminUsers() {
    return _firestore.collection("AdminUsers").snapshots();
  }

  // Add Opportunity
  Future<String?> addOppurtunity(OpportunityModel opportunity) async {
    try {
      final docRef = _firestore.collection("Opportunities").doc();

      final opp = opportunity.update("uid", docRef.id);

      await docRef.set(opp.toMap());
      return null;
    } catch(e) {
      return e.toString();
    }
  }

  // UPDATE Opportunity
  Future<String?> updateOpportunity(OpportunityModel opportunity) async {
    try {
      await _firestore
          .collection("Opportunities")
          .doc(opportunity.uid)
          .update(opportunity.toMap());

      return null;
    } catch(e) {
      print(e.toString());
      return "Unable to execute the request. Please try again later";
    }
  }

  // Get Oppurtunities
  Stream<QuerySnapshot> getOpportunities() {
    return _firestore.collection("Opportunities").snapshots();
  }

  // Update the status of the admin user
  Future<String ?> updateStatus(String email, String status) async {
    try {
      final querySnapshot = await _firestore
                        .collection("AdminUsers")
                        .where('email', isEqualTo: email)
                        .get();
      
      for(var doc in querySnapshot.docs) {
        await doc.reference.update({'status' : status});
      }
      return null;
    } catch(e) {
      print(e.toString());
      return "Unable to execute the request. Please try again later";
    }
  }

  // Delete the Opportunity
  Future<void> deleteOpportunity(String title) async {
    try {
      final querySnapshot = await _firestore
          .collection("Opportunities")
          .where('title', isEqualTo: title)
          .get();

      if(querySnapshot.docs.isEmpty) return;

      for(var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch(e) {
      print(e.toString());
    }
  }

  // APPLICANTS
  Stream<QuerySnapshot> getApplicants(String uid) {
    return _firestore
        .collection("Opportunities")
        .doc(uid)
        .collection("Applicants")
        .snapshots();
  }

  // SELECTED APPLICANTS
  Stream<QuerySnapshot> getSelectedCount(String uid) {
    return _firestore
        .collection("Opportunities")
        .doc(uid)
        .collection("Applicants")
        .where("Status", isEqualTo: "Selected")
        .snapshots();
  }
}