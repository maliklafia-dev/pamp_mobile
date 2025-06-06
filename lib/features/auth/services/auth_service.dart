import 'package:url_launcher/url_launcher.dart';
import '../../../core/api/api_endpoints.dart';
import '../../../core/network/api_response.dart';
import '../../../core/network/pamp_api_client.dart';
import '../../../core/storage/teacher_token_storage.dart';
import '../models/auth_response.dart';
import '../models/login_request.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final PampApiClient _apiClient = PampApiClient();
  final TeacherTokenStorage _tokenStorage = TeacherTokenStorage();

  Future<ApiResponse<AuthResponse>> loginTeacher(LoginRequest loginRequest) async {
    final response = await _apiClient.postToAuthService<AuthResponse>(
      ApiEndpoints.teacherLogin,
      loginRequest.toJson(),
      fromJson: (json) => AuthResponse.fromJson(json),
    );

    if (response.isSuccess && response.data != null) {
      await _storeAuthData(response.data!);
    }

    return response;
  }

  Future<ApiResponse<String>> initiateGoogleLogin() async {
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

  Future<void> launchGoogleLogin(String authUrl) async {
    final uri = Uri.parse(authUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw Exception('Could not launch Google authentication');
    }
  }

  Future<ApiResponse<AuthResponse>> handleGoogleCallback(Map<String, String> params) async {
    final response = await _apiClient.postToAuthService<AuthResponse>(
      ApiEndpoints.googleLoginCallback,
      params,
      fromJson: (json) => AuthResponse.fromJson(json),
    );

    if (response.isSuccess && response.data != null) {
      await _storeAuthData(response.data!);
    }

    return response;
  }

  Future<ApiResponse<UserData>> getCurrentUser() async {
    final response = await _apiClient.getFromAuthService<UserData>(
      ApiEndpoints.teacherProfile,
      requiresAuthentication: true,
      fromJson: (json) => UserData.fromJson(json),
    );

    return response;
  }

  Future<void> _storeAuthData(AuthResponse authResponse) async {
    await _tokenStorage.saveTeacherToken(authResponse.token);
    if (authResponse.refreshToken != null) {
      await _tokenStorage.saveTeacherRefreshToken(authResponse.refreshToken!);
    }
    await _tokenStorage.saveTeacherId(authResponse.user.id);
    await _tokenStorage.saveTeacherEmail(authResponse.user.email);
  }

  Future<bool> isLoggedIn() async {
    return await _tokenStorage.hasValidTeacherToken();
  }

  Future<void> logout() async {
    await _tokenStorage.clearAllTeacherData();
  }

  Future<void> debugToken() async {
    final token = await _tokenStorage.getTeacherToken();
    print('Current token: $token');
  }
}
