import 'package:url_launcher/url_launcher.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/pamp_api_client.dart';
import '../../../core/storage/teacher_token_storage.dart';
import '../models/teacher_auth_response.dart';
import '../models/teacher_login_request.dart';

class TeacherAuthenticationService {
  static final TeacherAuthenticationService _instance = TeacherAuthenticationService._internal();
  factory TeacherAuthenticationService() => _instance;
  TeacherAuthenticationService._internal();

  final PampApiClient _apiClient = PampApiClient();
  final TeacherTokenStorage _tokenStorage = TeacherTokenStorage();

  Future<ApiResponse<TeacherAuthResponse>> authenticateTeacherWithCredentials(
      TeacherLoginRequest loginRequest,
      ) async {
    final response = await _apiClient.postToAuthService<TeacherAuthResponse>(
      ApiEndpoints.teacherLogin,
      loginRequest.toJson(),
      fromJson: (json) => TeacherAuthResponse.fromJson(json),
    );

    if (response.isSuccess && response.data != null) {
      await _storeTeacherAuthenticationData(response.data!);
    }

    return response;
  }

  Future<ApiResponse<String>> initiateGoogleAuthenticationForTeacher() async {
    try {
      final response = await _apiClient.getFromAuthService<Map<String, dynamic>>(
        ApiEndpoints.googleLogin,
      );

      if (response.isSuccess && response.data != null) {
        final googleAuthUrl = response.data!['authUrl'] as String?;
        if (googleAuthUrl != null) {
          return ApiResponse.success(googleAuthUrl);
        }
      }

      return ApiResponse.error('Failed to get Google authentication URL');
    } catch (e) {
      return ApiResponse.error('Google authentication error: ${e.toString()}');
    }
  }

  Future<void> launchGoogleAuthenticationUrl(String authUrl) async {
    final uri = Uri.parse(authUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch Google authentication');
    }
  }

  Future<ApiResponse<TeacherAuthResponse>> handleGoogleAuthenticationCallback(
      Map<String, String> callbackParameters,
      ) async {
    final response = await _apiClient.postToAuthService<TeacherAuthResponse>(
      ApiEndpoints.googleLoginCallback,
      callbackParameters,
      fromJson: (json) => TeacherAuthResponse.fromJson(json),
    );

    if (response.isSuccess && response.data != null) {
      await _storeTeacherAuthenticationData(response.data!);
    }

    return response;
  }

  Future<ApiResponse<TeacherProfile>> getAuthenticatedTeacherProfile() async {
    final response = await _apiClient.getFromAuthService<TeacherProfile>(
      ApiEndpoints.teacherProfile,
      requiresAuthentication: true,
      fromJson: (json) => TeacherProfile.fromJson(json),
    );

    return response;
  }

  Future<void> _storeTeacherAuthenticationData(TeacherAuthResponse authResponse) async {
    await _tokenStorage.saveTeacherToken(authResponse.accessToken);
    if (authResponse.refreshToken != null) {
      await _tokenStorage.saveTeacherRefreshToken(authResponse.refreshToken!);
    }
    await _tokenStorage.saveTeacherId(authResponse.teacherProfile.teacherId);
    await _tokenStorage.saveTeacherEmail(authResponse.teacherProfile.teacherEmail);
  }

  Future<bool> isTeacherAuthenticated() async {
    return await _tokenStorage.hasValidTeacherToken();
  }

  Future<void> logoutTeacher() async {
    await _tokenStorage.clearAllTeacherData();
  }
}
