class TeacherAuthResponse {
  final String accessToken;
  final String? refreshToken;
  final TeacherProfile teacherProfile;

  TeacherAuthResponse({
    required this.accessToken,
    this.refreshToken,
    required this.teacherProfile,
  });

  factory TeacherAuthResponse.fromJson(Map<String, dynamic> json) {
    return TeacherAuthResponse(
      accessToken: json['token'] ?? json['access_token'] ?? '',
      refreshToken: json['refreshToken'] ?? json['refresh_token'],
      teacherProfile: TeacherProfile.fromJson(json['user'] ?? json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'teacherProfile': teacherProfile.toJson(),
    };
  }
}

class TeacherProfile {
  final String teacherId;
  final String teacherEmail;
  final String? teacherFirstName;
  final String? teacherLastName;
  final String? teacherRole;
  final String? teacherPhotoUrl;

  TeacherProfile({
    required this.teacherId,
    required this.teacherEmail,
    this.teacherFirstName,
    this.teacherLastName,
    this.teacherRole,
    this.teacherPhotoUrl,
  });

  factory TeacherProfile.fromJson(Map<String, dynamic> json) {
    return TeacherProfile(
      teacherId: json['id']?.toString() ?? '',
      teacherEmail: json['email'] ?? '',
      teacherFirstName: json['firstName'] ?? json['first_name'],
      teacherLastName: json['lastName'] ?? json['last_name'],
      teacherRole: json['role'],
      teacherPhotoUrl: json['photoUrl'] ?? json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teacherId': teacherId,
      'teacherEmail': teacherEmail,
      'teacherFirstName': teacherFirstName,
      'teacherLastName': teacherLastName,
      'teacherRole': teacherRole,
      'teacherPhotoUrl': teacherPhotoUrl,
    };
  }

  String get teacherFullName {
    if (teacherFirstName != null && teacherLastName != null) {
      return '$teacherFirstName $teacherLastName';
    }
    return teacherFirstName ?? teacherLastName ?? teacherEmail;
  }
}
