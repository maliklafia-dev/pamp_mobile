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

    print('API Response isSuccess: ${response.isSuccess}');
    print('API Response Error: ${response.error}');
    print('API Response Data Type: ${response.data?.runtimeType}');
    print('API Response Data Raw: ${response.data}');

    if (response.isSuccess && response.data != null) {
      final projects = (response.data as List<dynamic>)
          .map((jsonItem) {
        if (jsonItem is Map<String, dynamic>) {
          return ProjectModel.fromJson(jsonItem);
        } else {
          print('Warning: Item in project list is not a Map: $jsonItem');
          throw FormatException('Invalid item format in project list');
        }
      })
          .toList();
      return ApiResponse.success(projects);
    }

    return ApiResponse.error(response.error ?? 'Failed to fetch projects (data was null or request failed)');
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
