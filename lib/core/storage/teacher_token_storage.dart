import 'package:shared_preferences/shared_preferences.dart';

class TeacherTokenStorage {
  static final TeacherTokenStorage _instance = TeacherTokenStorage._internal();
  factory TeacherTokenStorage() => _instance;
  TeacherTokenStorage._internal();

  static const String _teacherTokenKey = 'teacher_auth_token';
  static const String _teacherRefreshTokenKey = 'teacher_refresh_token';
  static const String _teacherIdKey = 'teacher_id';
  static const String _teacherEmailKey = 'teacher_email';

  Future<void> saveTeacherToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_teacherTokenKey, token);
  }

  Future<String?> getTeacherToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_teacherTokenKey);
  }

  Future<void> saveTeacherRefreshToken(String refreshToken) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_teacherRefreshTokenKey, refreshToken);
  }

  Future<String?> getTeacherRefreshToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_teacherRefreshTokenKey);
  }

  Future<void> saveTeacherId(String teacherId) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_teacherIdKey, teacherId);
  }

  Future<String?> getTeacherId() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_teacherIdKey);
  }

  Future<void> saveTeacherEmail(String email) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_teacherEmailKey, email);
  }

  Future<String?> getTeacherEmail() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_teacherEmailKey);
  }

  Future<void> clearAllTeacherData() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_teacherTokenKey);
    await preferences.remove(_teacherRefreshTokenKey);
    await preferences.remove(_teacherIdKey);
    await preferences.remove(_teacherEmailKey);
  }

  Future<bool> hasValidTeacherToken() async {
    final token = await getTeacherToken();
    return token != null && token.isNotEmpty;
  }
}
