class StudentBatchModel {
  final String studentBatchId;
  final String studentBatchName;
  final String? studentBatchState;
  final List<String> studentBatchTags;
  final List<String> studentIds;
  final String? associatedProjectId;

  StudentBatchModel({
    required this.studentBatchId,
    required this.studentBatchName,
    this.studentBatchState,
    this.studentBatchTags = const [],
    this.studentIds = const [],
    this.associatedProjectId,
  });

  factory StudentBatchModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedTags = [];
    final dynamic tagsData = json['tags']; // Récupérer la valeur de 'tags'

    if (tagsData is String) {

      if (tagsData.isNotEmpty) {
        parsedTags = tagsData
            .split(',')
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty)
            .toList();
      }

    } else if (tagsData is List) {

      parsedTags = List<String>.from(tagsData.map((item) => item.toString()));
    }

    List<String> parsedStudentIds = [];
    final dynamic studentsData = json['students'];
    if (studentsData is List) {
      parsedStudentIds = List<String>.from(studentsData.map((item) => item.toString()));
    }


    return StudentBatchModel(
      studentBatchId: json['id']?.toString() ?? '',
      studentBatchName: json['name'] ?? '',
      studentBatchState: json['state'] as String?,
      studentBatchTags: parsedTags,
      studentIds: parsedStudentIds,
      associatedProjectId: json['projects'] is List && (json['projects'] as List).isNotEmpty
          ? ((json['projects'] as List)[0] as Map<String, dynamic>)['id']?.toString()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': studentBatchId,
      'name': studentBatchName,
      'state': studentBatchState,
      'tags': studentBatchTags,
      'students': studentIds,
      'projectId': associatedProjectId,
    };
  }
}
