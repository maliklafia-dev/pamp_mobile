import 'package:flutter/material.dart';
import '../models/teacher_auth_response.dart';
import '../models/teacher_login_request.dart';
import '../services/teacher_authentication_service.dart';

class TeacherAuthenticationViewModel extends ChangeNotifier {
  final TeacherAuthenticationService _authService = TeacherAuthenticationService();

  bool _isAuthenticating = false;
  TeacherProfile? _authenticatedTeacher;
  String? _authenticationError;

  bool get isAuthenticating => _isAuthenticating;
  TeacherProfile? get authenticatedTeacher => _authenticatedTeacher;
  String? get authenticationError => _authenticationError;
  bool get isTeacherAuthenticated => _authenticatedTeacher != null;

  void _updateAuthenticationState({
    bool? isAuthenticating,
    TeacherProfile? authenticatedTeacher,
    // Use a specific sentinel or allow null to clear teacher vs. no change
    bool clearAuthenticatedTeacher = false,
    String? authenticationError,
    bool clearAuthenticationError = false,
  }) {
    bool changed = false;
    if (isAuthenticating != null && _isAuthenticating != isAuthenticating) {
      _isAuthenticating = isAuthenticating;
      changed = true;
    }
    if (clearAuthenticatedTeacher) {
      if (_authenticatedTeacher != null) {
        _authenticatedTeacher = null;
        changed = true;
      }
    } else if (authenticatedTeacher != null && _authenticatedTeacher != authenticatedTeacher) {
      // This condition might need adjustment based on TeacherProfile equality.
      // If TeacherProfile doesn't override == and hashCode, it will always be a new instance.
      // Or, you can just assign: _authenticatedTeacher = authenticatedTeacher; changed = true;
      _authenticatedTeacher = authenticatedTeacher;
      changed = true;
    }

    if (clearAuthenticationError) {
      if (_authenticationError != null) {
        _authenticationError = null;
        changed = true;
      }
    } else if (authenticationError != null && _authenticationError != authenticationError) {
      _authenticationError = authenticationError;
      changed = true;
    }

    if (changed) {
      notifyListeners();
    }
  }


  Future<void> checkTeacherAuthenticationStatus() async {
    _updateAuthenticationState(isAuthenticating: true, clearAuthenticationError: true);

    try {
      final isAuthenticatedInitially = await _authService.isTeacherAuthenticated();
      if (isAuthenticatedInitially) {
        final profileResponse = await _authService.getAuthenticatedTeacherProfile();
        if (profileResponse.isSuccess && profileResponse.data != null) {
          _updateAuthenticationState(authenticatedTeacher: profileResponse.data);
        } else {
          await _authService.logoutTeacher(); // Attempt to clear on server/storage
          _updateAuthenticationState(clearAuthenticatedTeacher: true);
          // Optionally set an error here if profile fetch failure is a distinct error state
          // _updateAuthenticationState(authenticationError: 'Failed to retrieve profile. Please log in again.');
        }
      } else {
        _updateAuthenticationState(clearAuthenticatedTeacher: true);
      }
    } catch (e) {
      _updateAuthenticationState(
        clearAuthenticatedTeacher: true,
        authenticationError: 'Failed to check authentication status: ${e.toString()}',
      );
    } finally {
      _updateAuthenticationState(isAuthenticating: false);
    }
  }

  Future<bool> authenticateTeacherWithEmailAndPassword(String email, String password) async {
    _updateAuthenticationState(isAuthenticating: true, clearAuthenticationError: true);
    bool success = false;

    try {
      final loginRequest = TeacherLoginRequest(
        teacherEmail: email,
        teacherPassword: password,
      );
      final response = await _authService.authenticateTeacherWithCredentials(loginRequest);

      if (response.isSuccess && response.data?.teacherProfile != null) {
        _updateAuthenticationState(authenticatedTeacher: response.data!.teacherProfile);
        success = true;
      } else {
        _updateAuthenticationState(authenticationError: response.error ?? 'Authentication failed');
        success = false;
      }
    } catch (e) {
      _updateAuthenticationState(authenticationError: 'An error occurred. Please try again: ${e.toString()}');
      success = false;
    } finally {
      _updateAuthenticationState(isAuthenticating: false);
    }
    return success;
  }

  Future<bool> initiateGoogleAuthenticationForTeacher() async {
    _updateAuthenticationState(isAuthenticating: true, clearAuthenticationError: true);
    bool success = false;

    try {
      final response = await _authService.initiateGoogleAuthenticationForTeacher();

      if (response.isSuccess && response.data != null) {
        // Assuming launchGoogleAuthenticationUrl is synchronous or doesn't change auth state directly here
        await _authService.launchGoogleAuthenticationUrl(response.data!);
        // The actual authentication might happen after a redirect and be handled by checkTeacherAuthenticationStatus
        // or a dedicated callback handler. If this call means success, then:
        success = true;
        // If the Google auth flow has its own callback that updates the state,
        // you might not even set authenticatedTeacher here directly.
        // For simplicity, let's assume success here means the process is initiated.
      } else {
        _updateAuthenticationState(authenticationError: response.error ?? 'Google authentication failed');
        success = false;
      }
    } catch (e) {
      _updateAuthenticationState(authenticationError: 'An error occurred with Google Sign-In: ${e.toString()}');
      success = false;
    } finally {
      _updateAuthenticationState(isAuthenticating: false);
    }
    return success;
  }

  Future<void> logoutTeacher() async {
    _updateAuthenticationState(isAuthenticating: true, clearAuthenticationError: true);
    try {
      await _authService.logoutTeacher();
      _updateAuthenticationState(clearAuthenticatedTeacher: true);
    } catch (e) {
      // Even if logout on service fails, we clear local state
      _updateAuthenticationState(
        clearAuthenticatedTeacher: true,
        authenticationError: 'An error occurred during logout: ${e.toString()}',
      );
    } finally {
      _updateAuthenticationState(isAuthenticating: false);
    }
  }
}