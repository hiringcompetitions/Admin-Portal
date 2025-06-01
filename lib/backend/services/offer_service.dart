import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hiring_competitions_admin_portal/backend/models/opportunity_model.dart';

class OfferService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
 
 String generateOfferDocId() {
  return _firestore.collection('offers').doc().id;
}


  Future<void> addOffer(OpportunityModel offer) async {
  try {
    await _firestore.collection('Opportunities').doc(offer.uid).set(offer.toMap());
  } catch (e) {
    throw Exception(e.toString());
  }
}

}
