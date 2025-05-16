import 'package:flutter/material.dart';
import 'package:pamp_mobile/features/auth/model/userModel.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  UserModel? _user;
  String? _error;

  bool get isLoading => _isLoading;
  UserModel? get user => _user;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<bool> loginWithEmail(String email, String password) async {
    setLoading(true);
    setError(null);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes, accept any non-empty email/password
      if (email.isNotEmpty && password.isNotEmpty) {
        final user = UserModel(
          id: '1',
          email: email,
          name: 'Test User',
        );
        setUser(user);
        setLoading(false);
        return true;
      } else {
        setError('Invalid email or password');
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
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      final user = UserModel(
        id: '2',
        email: 'google@example.com',
        name: 'Google User',
        photoUrl: 'https://example.com/avatar.jpg',
      );

      setUser(user);
      setLoading(false);
      return true;
    } catch (e) {
      setError('An error occurred with Google Sign-In. Please try again.');
      setLoading(false);
      return false;
    }
  }

  Future<void> logout() async {
    setLoading(true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      setUser(null);
    } catch (e) {
      setError('An error occurred during logout. Please try again.');
    } finally {
      setLoading(false);
    }
  }
}
