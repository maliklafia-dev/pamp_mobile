class StudentModel {
  final String studentId;
  final String studentFullName;
  final String studentLastName;


  StudentModel( {
    required this.studentId,
    this.studentFullName = '',
    this.studentLastName = ''
  });
}