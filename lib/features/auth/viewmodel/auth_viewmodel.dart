import 'package:flutter/material.dart';
import '../models/auth_response.dart';
import '../models/login_request.dart';
import '../services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  UserData? _user;
  String? _error;

  bool get isLoading => _isLoading;
  UserData? get user => _user;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setUser(UserData? user) {
    _user = user;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    setLoading(true);

    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (isLoggedIn) {
        final response = await _authService.getCurrentUser();
        if (response.isSuccess && response.data != null) {
          setUser(response.data);
        } else {
          // Token might be expired, logout
          await _authService.logout();
        }
      }
    } catch (e) {
      setError('Failed to check authentication status');
    } finally {
      setLoading(false);
    }
  }

  Future<bool> loginWithEmail(String email, String password) async {
    setLoading(true);
    setError(null);

    try {
      final request = LoginRequest(email: email, password: password);
      final response = await _authService.loginTeacher(request);

      if (response.isSuccess && response.data != null) {
        setUser(response.data!.user);
        setLoading(false);
        return true;
      } else {
        setError(response.error ?? 'Login failed');
        setLoading(false);
        return false;
      }
    } catch (e) {
      setError('An error occurred. Please try again.');
      setLoading(false);
      return false;
    }
  }

  Future<bool> loginWithGoogle() async {
    setLoading(true);
    setError(null);

    try {
      final response = await _authService.initiateGoogleLogin();

      if (response.isSuccess && response.data != null) {
        await _authService.launchGoogleLogin(response.data!);
        setLoading(false);
        return true;
      } else {
        setError(response.error ?? 'Google login failed');
        setLoading(false);
        return false;
      }
    } catch (e) {
      setError('An error occurred with Google Sign-In. Please try again.');
      setLoading(false);
      return false;
    }
  }

  Future<bool> handleGoogleCallback(Map<String, String> params) async {
    setLoading(true);
    setError(null);

    try {
      final response = await _authService.handleGoogleCallback(params);

      if (response.isSuccess && response.data != null) {
        setUser(response.data!.user);
        setLoading(false);
        return true;
      } else {
        setError(response.error ?? 'Google login callback failed');
        setLoading(false);
        return false;
      }
    } catch (e) {
      setError('An error occurred during Google authentication.');
      setLoading(false);
      return false;
    }
  }

  Future<void> logout() async {
    setLoading(true);

    try {
      await _authService.logout();
      setUser(null);
    } catch (e) {
      setError('An error occurred during logout. Please try again.');
    } finally {
      setLoading(false);
    }
  }
}
