import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hiring_competitions_admin_portal/backend/models/opportunity_model.dart';
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

  // Get Admin Status
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

  // Get Users by Batch
  Stream<QuerySnapshot> getUsersByBatch(String batch) {
    return _services.getUsersByBatch(batch);
  }

  // Get Batches
  Stream<QuerySnapshot> getBatches() {
    return _services.getBatches();
  }

  // Add New Batch
  Future<String?> addNewBatch(int batch) async {
    try {
      _isLoading = true;
      notifyListeners();
      final res = await _services.addNewBatch(batch);
      _isLoading = false;
      notifyListeners();
      return res;
    } catch(e) {
      return "An unexpected error Occured. Please try again later";
    }
  }
 
  // Get Admin Users
  Stream<QuerySnapshot> getAdminUsers() {
    return _services.getAdminUsers();
  }

  // Add Opportunities
  Future<String?> addOppurtunity(OpportunityModel opportunity) async {
    try {
      _isLoading = true;
      notifyListeners();
      final res = await _services.addOppurtunity(opportunity);
      _isLoading = false;
      notifyListeners();
      return res;
    } catch(e) {
      return "Unknown error occured. Please try again later";
    }
  } 

  // Update Opportunity
  Future<String?> updateOpportunity(OpportunityModel opportunity) async {
    try {
      _isLoading = true;
      notifyListeners();
      final res = await _services.updateOpportunity(opportunity);
      _isLoading = false;
      notifyListeners();
      return res;
    } catch(e) {
      _isLoading = false;
      notifyListeners();
      return "Unknown error occured. Please try again later";
    }
  }

  // Get Opportunities
  Stream<QuerySnapshot> getOpportunities() {
    return _services.getOpportunities();
  }

  // Delete Opportunity
  Future<void> deleteOpportunity(String title) async {
    await _services.deleteOpportunity(title);
  }

  // Update Status
  Future<String?> updateStatus(String email, String status) async {
    try {
      final res = await _services.updateStatus(email, status);
      return res;
    } catch(e) {
      return "Unexpected error occured. Please try again later";
    }
  }

  // APPLICANTS
  Stream<QuerySnapshot> getApplicants(String uid) {
    return _services.getApplicants(uid);
  }

  // SELECTED APPLICANTS COUNT
  Stream<QuerySnapshot> getSelectedCount(String uid) {
    return _services.getSelectedCount(uid);
  }

  // Get Top Picks
  Stream<QuerySnapshot> getTopPicks() {
    return _services.getTopPicks();
  }

  // Update status of opportunities
  void updateOpportunityStatus() {
    _services.updateOpportunityStatus();
  }
}