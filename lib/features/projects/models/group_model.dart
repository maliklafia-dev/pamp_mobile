class GroupModel {
  final String groupId;
  final String groupName;
  final DateTime? createdAt;
  final bool? reportSubmitted; // Si un rapport/livrable a été soumis
  final DateTime? reportSubmittedDate;
  final List<String> studentIds; // IDs des étudiants dans le groupe

  GroupModel({
    required this.groupId,
    required this.groupName,
    this.createdAt,
    this.reportSubmitted,
    this.reportSubmittedDate,
    this.studentIds = const [],
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedStudentIds = [];
    final dynamic studentsData = json['studentsIds'];

    if (studentsData is String) {
      if (studentsData.isNotEmpty) {
        parsedStudentIds = studentsData
            .split(',')
            .map((id) => id.trim())
            .where((id) => id.isNotEmpty)
            .toList();
      }
    } else if (studentsData is List) {
      // Au cas où l'API changerait pour une vraie liste
      parsedStudentIds = List<String>.from(
          studentsData.map((item) => item.toString().trim()).where((id) => id.isNotEmpty));
    }

    return GroupModel(
      groupId: json['id']?.toString() ?? '', // Devrait idéalement lever une erreur si null
      groupName: json['name']?.toString() ?? '', // Idem
      createdAt: json['createdAt'] != null && json['createdAt'] is String
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      reportSubmitted: json['reportSubmitted'] as bool?,
      reportSubmittedDate:
      json['reportSubmittedDate'] != null && json['reportSubmittedDate'] is String
          ? DateTime.tryParse(json['reportSubmittedDate'] as String)
          : null,
      studentIds: parsedStudentIds,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': groupId,
      'name': groupName,
      'createdAt': createdAt?.toIso8601String(),
      'reportSubmitted': reportSubmitted,
      'reportSubmittedDate': reportSubmittedDate?.toIso8601String(),
      'studentsIds': studentIds.join(','), // Reconvertir en chaîne si l'API l'attend ainsi
    };
  }
}