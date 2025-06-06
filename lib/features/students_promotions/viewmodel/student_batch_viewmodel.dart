import 'package:flutter/material.dart';
import '../models/students_batch_model.dart';
import '../services/student_batch_service.dart';

class StudentBatchViewModel extends ChangeNotifier {
  final StudentBatchService _studentBatchService = StudentBatchService();

  bool _isLoadingStudentBatches = false;
  List<StudentBatchModel> _studentBatches = [];
  String? _studentBatchError;

  bool get isLoadingStudentBatches => _isLoadingStudentBatches;
  List<StudentBatchModel> get studentBatches => _studentBatches;
  String? get studentBatchError => _studentBatchError;

  void _setLoadingStudentBatches(bool loading) {
    _isLoadingStudentBatches = loading;
    notifyListeners();
  }

  void _setStudentBatches(List<StudentBatchModel> batches) {
    _studentBatches = batches;
    notifyListeners();
  }

  void _setStudentBatchError(String? error) {
    _studentBatchError = error;
    notifyListeners();
  }

  Future<void> fetchAllStudentBatches() async {
    _setLoadingStudentBatches(true);
    _setStudentBatchError(null);

    try {
      final response = await _studentBatchService.getAllStudentBatches();

      if (response.isSuccess && response.data != null) {
        _setStudentBatches(response.data!);
      } else {
        _setStudentBatchError(response.error ?? 'Failed to load student batches');
      }
    } catch (e) {
      _setStudentBatchError('Failed to load student batches. Please try again.');
    } finally {
      _setLoadingStudentBatches(false);
    }
  }
}
