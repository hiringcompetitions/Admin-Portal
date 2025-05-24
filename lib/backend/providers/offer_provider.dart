import 'package:flutter/material.dart';
import 'package:hiring_competitions_admin_portal/constants/custom_error.dart';
import '../models/offer_model.dart';
import '../services/offer_service.dart';

class OfferProvider extends ChangeNotifier {
  final titleController = TextEditingController();
  final companyController = TextEditingController();
  final eligibilityController = TextEditingController();
  final durationController = TextEditingController();
  final deadlineController = TextEditingController();
  final rewardController = TextEditingController();
  final locationController = TextEditingController();
  final aboutController = TextEditingController();
  final otherInfoController = TextEditingController();

  String selectedCategory = '';
  bool isTopPick = false;
  bool _isLoading=false;
  bool get isLoading=>_isLoading;

  final OfferService _offerService = OfferService();

  void setCategory(String value) {
    selectedCategory = value;
    notifyListeners();
  }

  void toggleTopPick(bool value) {
    isTopPick = value;
    notifyListeners();
  }
  List<String> parseOtherInfo(String rawText) {
  final lines = rawText.split('\n');
  return lines
      .map((line) => line.replaceAll(RegExp(r'^[•\-\*\s]+'), '').trim())
      .where((line) => line.isNotEmpty)
      .toList();
   }

  Future<void> submitOffer() async {
    final otherinfo=parseOtherInfo(otherInfoController.text);
    _isLoading=true;
    notifyListeners();
    final offer = OfferModel(
      title: titleController.text.trim(),
      category: selectedCategory,
      company: companyController.text.trim(),
      eligibility: eligibilityController.text.trim(),
      duration: durationController.text.trim(),
      deadline: deadlineController.text.trim(),
      reward: rewardController.text.trim(),
      location: locationController.text.trim(),
      about: aboutController.text.trim(),
      otherInfo: otherinfo,
      isTopPick: isTopPick,
      timestamp: DateTime.now(),
    );

    try{
      await _offerService.addOffer(offer);
    }
    catch(e){
         print(e);
    }
    _isLoading=false;
    notifyListeners();

  }

  void disposeControllers() {
    titleController.dispose();
    companyController.dispose();
    eligibilityController.dispose();
    durationController.dispose();
    deadlineController.dispose();
    rewardController.dispose();
    locationController.dispose();
    aboutController.dispose();
    otherInfoController.dispose();
  }
}
