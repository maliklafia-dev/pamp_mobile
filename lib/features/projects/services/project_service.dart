import '../../../core/api/api_endpoints.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/pamp_api_client.dart';
import '../models/project_model.dart';

class ProjectService {
  static final ProjectService _instance = ProjectService._internal();
  factory ProjectService() => _instance;
  ProjectService._internal();

  final PampApiClient _apiClient = PampApiClient();

  Future<ApiResponse<List<ProjectModel>>> getAllProjects() async {
    final response = await _apiClient.getFromProjectsService<List<dynamic>>(
      ApiEndpoints.projects,
      requiresAuthentication: true,
    );

    if (response.isSuccess && response.data != null) {
      final projects = (response.data as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return ApiResponse.success(projects);
    }

    return ApiResponse.error(response.error ?? 'Failed to fetch projects');
  }

  Future<ApiResponse<List<ProjectModel>>> getProjectsByStudentBatch(String studentBatchId) async {
    final allProjectsResponse = await getAllProjects();

    if (allProjectsResponse.isSuccess && allProjectsResponse.data != null) {
      final filteredProjects = allProjectsResponse.data!
          .where((project) => project.linkedStudentBatchId == studentBatchId)
          .toList();
      return ApiResponse.success(filteredProjects);
    }

    return ApiResponse.error(allProjectsResponse.error ?? 'Failed to fetch projects for student batch');
  }
}
