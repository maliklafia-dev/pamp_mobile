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
    return StudentBatchModel(
      studentBatchId: json['id']?.toString() ?? '',
      studentBatchName: json['name'] ?? '',
      studentBatchState: json['state'],
      studentBatchTags: List<String>.from(json['tags'] ?? []),
      studentIds: List<String>.from(json['students'] ?? []),
      associatedProjectId: json['projectId']?.toString(),
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
