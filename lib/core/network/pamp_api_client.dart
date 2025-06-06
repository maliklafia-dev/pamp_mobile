import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../api/api_endpoints.dart';
import '../storage/teacher_token_storage.dart';
import 'api_response.dart';

class PampApiClient {
  static final PampApiClient _instance = PampApiClient._internal();
  factory PampApiClient() => _instance;
  PampApiClient._internal();

  final http.Client _httpClient = http.Client();
  final TeacherTokenStorage _tokenStorage = TeacherTokenStorage();

  Future<Map<String, String>> _buildHeaders({bool requiresAuthentication = false}) async {
    final headers = {
      'Content-Type': ApiEndpoints.contentTypeJson,
      'Accept': ApiEndpoints.contentTypeJson,
    };

    if (requiresAuthentication) {
      final teacherToken = await _tokenStorage.getTeacherToken();
      if (teacherToken != null) {
        headers[ApiEndpoints.authorizationHeader] = '${ApiEndpoints.bearerPrefix} $teacherToken';
      }
    }

    return headers;
  }

  Future<ApiResponse<T>> getFromAuthService<T>(
      String endpoint, {
        bool requiresAuthentication = false,
        T Function(Map<String, dynamic>)? fromJson,
      }) async {
    return _makeRequest<T>(
      'GET',
      '${ApiEndpoints.authBaseUrl}$endpoint',
      requiresAuthentication: requiresAuthentication,
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> postToAuthService<T>(
      String endpoint,
      Map<String, dynamic> requestBody, {
        bool requiresAuthentication = false,
        T Function(Map<String, dynamic>)? fromJson,
      }) async {
    return _makeRequest<T>(
      'POST',
      '${ApiEndpoints.authBaseUrl}$endpoint',
      requestBody: requestBody,
      requiresAuthentication: requiresAuthentication,
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> getFromProjectsService<T>(
      String endpoint, {
        bool requiresAuthentication = true,
        T Function(Map<String, dynamic>)? fromJson,
      }) async {
    return _makeRequest<T>(
      'GET',
      '${ApiEndpoints.projectsBaseUrl}$endpoint',
      requiresAuthentication: requiresAuthentication,
      fromJson: fromJson,
    );
  }

  Future<ApiResponse<T>> _makeRequest<T>(
      String method,
      String url, {
        Map<String, dynamic>? requestBody,
        bool requiresAuthentication = false,
        T Function(Map<String, dynamic>)? fromJson,
      }) async {
    try {
      final uri = Uri.parse(url);
      final headers = await _buildHeaders(requiresAuthentication: requiresAuthentication);

      http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await _httpClient.get(uri, headers: headers);
          break;
        case 'POST':
          response = await _httpClient.post(
            uri,
            headers: headers,
            body: requestBody != null ? jsonEncode(requestBody) : null,
          );
          break;
        default:
          throw UnsupportedError('HTTP method $method not supported');
      }

      return _processResponse<T>(response, fromJson);
    } catch (e) {
      return ApiResponse.error('Network error: ${e.toString()}');
    }
  }

  ApiResponse<T> _processResponse<T>(
      http.Response response,
      T Function(Map<String, dynamic>)? fromJson,
      ) {
    try {
      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (fromJson != null) {
          return ApiResponse.success(fromJson(responseData));
        } else {
          return ApiResponse.success(responseData as T);
        }
      } else {
        final errorMessage = responseData['message'] ?? 'Unknown error occurred';
        return ApiResponse.error(errorMessage);
      }
    } catch (e) {
      return ApiResponse.error('Failed to parse response: ${e.toString()}');
    }
  }

  void dispose() {
    _httpClient.close();
  }
}
