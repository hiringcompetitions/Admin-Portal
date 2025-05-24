import 'package:flutter/material.dart';

class DropdownProvider with ChangeNotifier {

  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  String? _selectedBranch;
  String? get selectedranch => _selectedBranch;

  String? _selectedBatch;
  String? get selectedBatch => _selectedBatch;

  bool isChecked = false;

  void setCategory(String value) {
    _selectedCategory = value;
    notifyListeners(); 
  }

  void setBranch(String value) {
    _selectedBranch = value;
    notifyListeners(); 
  }

  void setBatch(String value) {
    _selectedBatch = value;
    notifyListeners(); 
  }

  void toggleCheckbox(bool? value) {
    isChecked = value ?? false;
    notifyListeners();
  }
}
