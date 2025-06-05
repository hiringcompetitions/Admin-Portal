import 'package:flutter/material.dart';
import 'package:hiring_competitions_admin_portal/backend/services/pie_chart_services.dart';

class PieChartProvider extends ChangeNotifier {
  PieChartServices _service=PieChartServices();

  Map<String, int> _branchCounts = {};
  bool _isLoading = false;

  Map<String, int> get branchCounts => _branchCounts;
  bool get isLoading => _isLoading;

  Future<void> loadBranchCounts(String opportunityId) async {
    _isLoading = true;
    notifyListeners();

    _branchCounts = await _service.fetchBranchCounts(opportunityId);

    _isLoading = false;
    notifyListeners();
  }
}
