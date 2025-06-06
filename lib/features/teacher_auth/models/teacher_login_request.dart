class TeacherLoginRequest {
  final String teacherEmail;
  final String teacherPassword;

  TeacherLoginRequest({
    required this.teacherEmail,
    required this.teacherPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': teacherEmail,
      'password': teacherPassword,
    };
  }

}
