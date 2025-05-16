import 'package:flutter/material.dart';
import '../models/deliverable_model.dart';

class DeliverablesViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<DeliverableModel> _deliverables = [];
  String? _error;

  bool get isLoading => _isLoading;
  List<DeliverableModel> get deliverables => _deliverables;
  String? get error => _error;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setDeliverables(List<DeliverableModel> deliverables) {
    _deliverables = deliverables;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<void> fetchDeliverables(String promotion) async {
    setLoading(true);
    setError(null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      final deliverables = [
        DeliverableModel(
          id: '1',
          groupName: 'Group Name',
          deliveryDate: DateTime(2025, 4, 1),
          compliance: 100,
          similarity: 5,
        ),
        DeliverableModel(
          id: '2',
          groupName: 'Group Name',
          deliveryDate: DateTime(2025, 4, 11),
          compliance: 100,
          similarity: 0,
        ),
        DeliverableModel(
          id: '3',
          groupName: 'Group Name',
          deliveryDate: DateTime(2025, 4, 5),
          compliance: 100,
          similarity: 0,
        ),
        DeliverableModel(
          id: '4',
          groupName: 'Group Name',
          deliveryDate: DateTime(2025, 4, 14),
          compliance: 100,
          similarity: 100,
        ),
        DeliverableModel(
          id: '5',
          groupName: 'Group Name',
          deliveryDate: DateTime(2025, 4, 2),
          compliance: 100,
          similarity: 0,
        ),
      ];

      setDeliverables(deliverables);
    } catch (e) {
      setError('Failed to load deliverables. Please try again.');
    } finally {
      setLoading(false);
    }
  }
}
