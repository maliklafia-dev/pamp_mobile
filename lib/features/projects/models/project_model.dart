class ProjectModel {
  final String id;
  final String name;
  final String promotion;
  final DateTime deadline;
  final bool hasDeliverables;

  ProjectModel({
    required this.id,
    required this.name,
    required this.promotion,
    required this.deadline,
    this.hasDeliverables = true,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      name: json['name'],
      promotion: json['promotion'],
      deadline: DateTime.parse(json['deadline']),
      hasDeliverables: json['hasDeliverables'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'promotion': promotion,
      'deadline': deadline.toIso8601String(),
      'hasDeliverables': hasDeliverables,
    };
  }
}