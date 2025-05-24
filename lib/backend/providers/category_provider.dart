import 'package:flutter/material.dart';

class DropdownProvider with ChangeNotifier {
  String _selectedItem = 'Select';

  String get selectedItem => _selectedItem;

  void setSelectedItem(String value) {
    _selectedItem = value;
    notifyListeners(); 
  }
  bool isChecked = false;

  void toggleCheckbox(bool? value) {
    isChecked = value ?? false;
    notifyListeners();
  }
}
