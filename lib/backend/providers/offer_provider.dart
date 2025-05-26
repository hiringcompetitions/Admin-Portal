import 'package:flutter/material.dart';
import '../models/offer_model.dart';
import '../services/offer_service.dart';
import 'package:intl/intl.dart';

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
  final urlController=TextEditingController();

  String selectedCategory = '';
  bool isTopPick = false;
  bool _isLoading = false;
  bool get isLoading=>_isLoading;
  bool _isadded=false;
  bool get isadded=> _isadded;
  List<String> _selectedCategories = [];
  List<String> get selectedCategories => _selectedCategories;

  final OfferService _offerService = OfferService();

  void setCategory(String value) {
    selectedCategory = value;
    notifyListeners();
  }

  void toggleTopPick(bool value) {
    isTopPick = value;
    notifyListeners();
  }
  
  //elligibility selector
   void updateSelectedCategories(List<String> categories) {
  _selectedCategories = categories;
  notifyListeners();
}


  //lastdate provider
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      String formatted = DateFormat('yyyy-MM-dd').format(picked);
      deadlineController.text = formatted;
      notifyListeners();
    }
  }



  List<String> parseOtherInfo(String rawText) {
  final lines = rawText.split('\n');
  return lines
      .map((line) => line.replaceAll(RegExp(r'^[•\-\*\s]+'), '').trim())
      .where((line) => line.isNotEmpty)
      .toList();
   }

  Future<void> submitOffer() async {
    final uid=await _offerService.generateOfferDocId();
    final otherinfo=parseOtherInfo(otherInfoController.text);
    _isLoading=true;
    notifyListeners();
    final offer = OfferModel(
      title: titleController.text.trim(),
      category: selectedCategory,
      organization: companyController.text.trim(),
      eligibility: eligibilityController.text.trim(),
      duration: durationController.text.trim(),
      lastdate: deadlineController.text.trim(),
      payout: rewardController.text.trim(),
      location: locationController.text.trim(),
      about: aboutController.text.trim(),
      otherInfo: otherinfo,
      isTopPick: isTopPick,
      url: urlController.text.trim(),
      timestamp: DateTime.now(),
      uid:uid,
    );

    try{
      await _offerService.addOffer(offer);
      _isadded=true;
      clearFormFields();
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
    urlController.dispose();
  }

  void clearFormFields() {
  titleController.clear();
  companyController.clear();
  eligibilityController.clear();
  durationController.clear();
  deadlineController.clear();
  rewardController.clear();
  locationController.clear();
  aboutController.clear();
  otherInfoController.clear();
  urlController.clear();
  selectedCategory = '';
  isTopPick = false;
  notifyListeners();
}

}
