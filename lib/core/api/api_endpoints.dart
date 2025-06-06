class ApiEndpoints {
  // Base URLs
  static const String authBaseUrl = 'https://auth.edulor.fr';
  static const String projectsBaseUrl = 'https://projects.edulor.fr';

  // Authentication endpoints (Teachers only)
  static const String teacherLogin = '/login/teacher';
  static const String googleLogin = '/login/google';
  static const String googleLoginCallback = '/login/callback/google';
  static const String teacherProfile = '/me';
  static const String debugToken = '/debug-token';

  // Projects Service endpoints
  static const String studentBatches = '/student-batches';
  static const String studentBatchById = '/student-batches/{id}';
  static const String projects = '/projects';
  static const String projectById = '/projects/{id}';

  // Headers
  static const String contentTypeJson = 'application/json';
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer';
}
