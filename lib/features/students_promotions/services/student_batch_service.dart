
import '../../../core/api/api_endpoints.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/pamp_api_client.dart';
import '../models/students_batch_model.dart';

class StudentBatchService {
  static final StudentBatchService _instance = StudentBatchService._internal();
  factory StudentBatchService() => _instance;
  StudentBatchService._internal();

  final PampApiClient _apiClient = PampApiClient();

  Future<ApiResponse<List<StudentBatchModel>>> getAllStudentBatches() async {
    final response = await _apiClient.getFromProjectsService<List<dynamic>>(
      ApiEndpoints.studentBatches,
      requiresAuthentication: true,
    );

    if (response.isSuccess && response.data != null) {
      final studentBatches = (response.data as List<dynamic>)
          .map((json) => StudentBatchModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return ApiResponse.success(studentBatches);
    }

    return ApiResponse.error(response.error ?? 'Failed to fetch student batches');
  }
}
