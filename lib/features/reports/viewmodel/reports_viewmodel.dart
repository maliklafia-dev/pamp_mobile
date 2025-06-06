import 'package:flutter/material.dart';
import '../models/report_model.dart';

class ReportsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<ReportModel> _reports = [];
  String? _error;

  bool get isLoading => _isLoading;
  List<ReportModel> get reports => _reports;
  String? get error => _error;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setReports(List<ReportModel> reports) {
    _reports = reports;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<void> fetchReports(String promotion) async {
    setLoading(true);
    setError(null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      final reports = [
        ReportModel(
          id: '1',
          groupName: 'Group Name',
          deliveryDate: DateTime(2025, 4, 1),
        ),
        ReportModel(
          id: '2',
          groupName: 'Group Name',
          deliveryDate: DateTime(2025, 4, 11),
        ),
        ReportModel(
          id: '3',
          groupName: 'Group Name',
          deliveryDate: DateTime(2025, 4, 5),
        ),
        ReportModel(
          id: '4',
          groupName: 'Group Name',
          deliveryDate: DateTime(2025, 4, 14),
        ),
        ReportModel(
          id: '5',
          groupName: 'Group Name',
          deliveryDate: DateTime(2025, 4, 2),
        ),
      ];

      setReports(reports);
    } catch (e) {
      setError('Failed to load reports. Please try again.');
    } finally {
      setLoading(false);
    }
  }

  Future<void> readReport(String reportId) async {
    // Implement read report functionality
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> giveNote(String reportId) async {
    // Implement give note functionality
    await Future.delayed(const Duration(seconds: 1));
  }
}
