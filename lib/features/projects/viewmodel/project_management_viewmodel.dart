import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../services/project_service.dart';

class ProjectManagementViewModel extends ChangeNotifier {
  final ProjectService _projectService = ProjectService();

  bool _isLoadingProjects = false;
  List<ProjectModel> _projects = [];
  String? _projectError;

  bool get isLoadingProjects => _isLoadingProjects;
  List<ProjectModel> get projects => _projects;
  String? get projectError => _projectError;

  void _setLoadingProjects(bool loading) {
    _isLoadingProjects = loading;
    notifyListeners();
  }

  void _setProjects(List<ProjectModel> projects) {
    _projects = projects;
    notifyListeners();
  }

  void _setProjectError(String? error) {
    _projectError = error;
    notifyListeners();
  }

  Future<void> fetchAllProjects() async {
    _setLoadingProjects(true);
    _setProjectError(null);

    try {
      final response = await _projectService.getAllProjects();

      if (response.isSuccess && response.data != null) {
        _setProjects(response.data!);
      } else {
        _setProjectError(response.error ?? 'Failed to load projects');
      }
    } catch (e) {
      _setProjectError('Failed to load projects. Please try again.');
    } finally {
      _setLoadingProjects(false);
    }
  }

  Future<List<ProjectModel>> getProjectsForStudentBatch(String studentBatchId) async {
    try {
      final response = await _projectService.getProjectsByStudentBatch(studentBatchId);

      if (response.isSuccess && response.data != null) {
        return response.data!;
      } else {
        _setProjectError(response.error ?? 'Failed to load projects for student batch');
        return [];
      }
    } catch (e) {
      _setProjectError('Failed to load projects for student batch. Please try again.');
      return [];
    }
  }
}
