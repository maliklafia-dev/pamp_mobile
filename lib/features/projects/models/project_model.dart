import 'group_model.dart'; // <<< IMPORTER LE NOUVEAU MODÈLE

class ProjectModel {
  final String projectId;
  final String projectName;
  final String? projectDescription;
  final bool isProjectPublished;
  final String? linkedStudentBatchId;
  final DateTime? projectCreatedAt;
  final DateTime? projectUpdatedAt;
  final List<GroupModel> groups; // <<< AJOUTER LA LISTE DES GROUPES

  ProjectModel({
    required this.projectId,
    required this.projectName,
    this.projectDescription,
    this.isProjectPublished = false,
    this.linkedStudentBatchId,
    this.projectCreatedAt,
    this.projectUpdatedAt,
    this.groups = const [], // <<< VALEUR PAR DÉFAUT
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    String? batchId;
    final dynamic studentBatchData = json['studentBatch'];
    if (studentBatchData is Map<String, dynamic>) {
      batchId = studentBatchData['id']?.toString();
    }

    List<GroupModel> parsedGroups = [];
    final dynamic groupsData = json['groups']; // <<< RÉCUPÉRER LES DONNÉES DES GROUPES
    if (groupsData is List) {
      parsedGroups = groupsData
          .where((groupJson) => groupJson is Map<String, dynamic>)
          .map((groupJson) => GroupModel.fromJson(groupJson as Map<String, dynamic>))
          .toList();
    }

    return ProjectModel(
      projectId: json['id']?.toString() ?? '',
      projectName: json['name'] ?? '',
      projectDescription: json['description'] as String?,
      isProjectPublished: (json['isPublished'] as bool?) ?? false,
      linkedStudentBatchId: batchId,
      projectCreatedAt: json['createdAt'] != null && json['createdAt'] is String
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      projectUpdatedAt: json['updatedAt'] != null && json['updatedAt'] is String
          ? DateTime.tryParse(json['updatedAt'] as String)
          : null,
      groups: parsedGroups, // <<< ASSIGNER LES GROUPES PARSÉS
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': projectId,
      'name': projectName,
      'description': projectDescription,
      'isPublished': isProjectPublished,
      'createdAt': projectCreatedAt?.toIso8601String(),
      'updatedAt': projectUpdatedAt?.toIso8601String(),
      'groups': groups.map((group) => group.toJson()).toList(), // <<< SÉRIALISER LES GROUPES
      // Note: linkedStudentBatchId est généralement géré différemment pour la sérialisation vers l'API
      // 'studentBatch': linkedStudentBatchId != null ? {'id': linkedStudentBatchId} : null,
    };
  }
}