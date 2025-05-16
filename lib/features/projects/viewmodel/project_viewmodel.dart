import 'package:flutter/material.dart';
import 'package:pamp_mobile/features/projects/models/project_model.dart';

class ProjectsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  List<ProjectModel> _projects = [];
  String? _error;

  bool get isLoading => _isLoading;
  List<ProjectModel> get projects => _projects;
  String? get error => _error;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setProjects(List<ProjectModel> projects) {
    _projects = projects;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<void> fetchProjects() async {
    setLoading(true);
    setError(null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock data
      final projects = [
        ProjectModel(
          id: '1',
          name: 'Project Name',
          promotion: 'Promotion A',
          deadline: DateTime(2025, 4, 12),
        ),
        ProjectModel(
          id: '2',
          name: 'Project Name',
          promotion: 'Promotion B',
          deadline: DateTime(2025, 5, 12),
        ),
        ProjectModel(
          id: '3',
          name: 'Project Name',
          promotion: 'Promotion C',
          deadline: DateTime(2025, 5, 22),
        ),
        ProjectModel(
          id: '4',
          name: 'Project Name',
          promotion: 'Promotion D',
          deadline: DateTime(2025, 6, 13),
        ),
        ProjectModel(
          id: '5',
          name: 'Project Name',
          promotion: 'Promotion X',
          deadline: DateTime(2025, 4, 30),
          hasDeliverables: false,
        ),
      ];

      setProjects(projects);
    } catch (e) {
      setError('Failed to load projects. Please try again.');
    } finally {
      setLoading(false);
    }
  }
}
