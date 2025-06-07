
import '../../../core/api/api_endpoints.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/pamp_api_client.dart';
import '../models/students_batch_model.dart';

// student_batch_service.dart
// ... imports ...

class StudentBatchService {
  static final StudentBatchService _instance = StudentBatchService._internal();
  factory StudentBatchService() => _instance;
  StudentBatchService._internal();

  final PampApiClient _apiClient = PampApiClient();

  Future<ApiResponse<List<StudentBatchModel>>> getAllStudentBatches() async {
    // T est List<dynamic>, fromJson n'est PAS fourni à _apiClient
    final response = await _apiClient.getFromProjectsService<List<dynamic>>( // Devrait probablement être getFromAuthService ou un service dédié aux batches si l'URL de base est différente
      ApiEndpoints.studentBatches, // Quel est cet endpoint ?
      requiresAuthentication: true,
    );

    print('--- getAllStudentBatches Debug ---');
    print('API Response isSuccess: ${response.isSuccess}');
    print('API Response Error: ${response.error}');
    print('API Response Data Type: ${response.data?.runtimeType}');
    print('API Response Data Raw: ${response.data}');
    print('--- End getAllStudentBatches Debug ---');

    if (response.isSuccess && response.data != null) {
      try {

        final studentBatches = (response.data as List<dynamic>)
            .map((json) {
          if (json is Map<String, dynamic>) {
            print('Mapping StudentBatch item: $json');
            return StudentBatchModel.fromJson(json);
          } else {
            print('Error: Item in student batch list is not a Map: $json. Skipping.');
            throw FormatException('Invalid item format in student batch list: expected Map, got ${json.runtimeType}');
          }
        })
            .toList();
        print('Mapped student batches count: ${studentBatches.length}');
        if (studentBatches.isEmpty && (response.data as List<dynamic>).isNotEmpty) {
          print('Warning: StudentBatches list was not empty before mapping, but is empty after. Check StudentBatchModel.fromJson.');
        }
        return ApiResponse.success(studentBatches);
      } catch (e, stackTrace) {
        print('Error during StudentBatchModel.fromJson mapping: $e');
        print('Stack trace for mapping error: $stackTrace');
        return ApiResponse.error('Failed to map student batches: ${e.toString()}');
      }
    }

    return ApiResponse.error(response.error ?? 'Failed to fetch student batches');
  }
}
