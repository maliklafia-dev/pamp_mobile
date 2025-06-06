class AuthResponse {
  final String token;
  final String? refreshToken;
  final UserData user;

  AuthResponse({
    required this.token,
    this.refreshToken,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'],
      user: UserData.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'user': user.toJson(),
    };
  }
}

class UserData {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? role;
  final String? photoUrl;

  UserData({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.photoUrl,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'],
      lastName: json['lastName'],
      role: json['role'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
      'photoUrl': photoUrl,
    };
  }

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    return firstName ?? lastName ?? email;
  }
}
