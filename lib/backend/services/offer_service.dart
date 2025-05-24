import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hiring_competitions_admin_portal/backend/models/offer_model.dart';

class OfferService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addOffer(OfferModel offer) async {
  try {
    await _firestore.collection('Opportunities').add(offer.toMap());
  } catch (e) {
    throw Exception(e.toString());
  }
}

}
