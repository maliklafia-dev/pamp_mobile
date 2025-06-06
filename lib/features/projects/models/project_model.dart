class ProjectModel {
  final String projectId;
  final String projectName;
  final String? projectDescription;
  final bool isProjectPublished;
  final String? linkedStudentBatchId;
  final DateTime? projectCreatedAt;
  final DateTime? projectUpdatedAt;

  ProjectModel({
    required this.projectId,
    required this.projectName,
    this.projectDescription,
    this.isProjectPublished = false,
    this.linkedStudentBatchId,
    this.projectCreatedAt,
    this.projectUpdatedAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectId: json['id']?.toString() ?? '',
      projectName: json['name'] ?? '',
      projectDescription: json['description'],
      isProjectPublished: json['isPublished'] ?? false,
      linkedStudentBatchId: json['studentBatchId']?.toString(),
      projectCreatedAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      projectUpdatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': projectId,
      'name': projectName,
      'description': projectDescription,
      'isPublished': isProjectPublished,
      'studentBatchId': linkedStudentBatchId,
      'createdAt': projectCreatedAt?.toIso8601String(),
      'updatedAt': projectUpdatedAt?.toIso8601String(),
    };
  }
}
