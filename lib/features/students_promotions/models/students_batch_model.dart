import 'package:pamp_mobile/features/projects/models/project_model.dart';

class StudentBatchModel {
  final String studentBatchId;
  final String? studentBatchState;
  final String studentBatchName;
  final List<String> studentBatchTags;
  final List<String> studentIds;
  final List<ProjectModel> projects; // Changé en non-nullable avec valeur par défaut

  StudentBatchModel({
    required this.studentBatchId,
    required this.studentBatchName,
    this.studentBatchState,
    this.studentBatchTags = const [],
    this.studentIds = const [],
    this.projects = const [], // Valeur par défaut pour la liste de projets
  });

  factory StudentBatchModel.fromJson(Map<String, dynamic> json) {
    // --- Parsing des Tags ---
    List<String> parsedTags = [];
    final dynamic tagsData = json['tags'];

    if (tagsData is String) {
      // Si 'tags' est une chaîne
      if (tagsData.isNotEmpty) {
        // Si la chaîne n'est pas vide, la découper.
        // S'il n'y a pas de séparateur et que la chaîne est le tag lui-même,
        // vous pourriez faire parsedTags = [tagsData.trim()];
        parsedTags = tagsData
            .split(',') // S'attendre à une chaîne séparée par des virgules
            .map((tag) => tag.trim())
            .where((tag) => tag.isNotEmpty) // Filtrer les tags vides après split
            .toList();
      }
      // Si tagsData est une chaîne vide, parsedTags restera []
    } else if (tagsData is List) {
      // Si 'tags' est déjà une liste
      parsedTags = List<String>.from(
        tagsData
            .where((item) => item != null) // Filtrer les éléments nuls potentiels
            .map((item) => item.toString().trim()) // Convertir en String et trim
            .where((tag) => tag.isNotEmpty), // Filtrer les tags vides
      );
    }
    // Si tagsData est null ou d'un autre type non géré, parsedTags restera []

    // --- Parsing des IDs Étudiants ---
    List<String> parsedStudentIds = [];
    final dynamic studentsData = json['students'];
    if (studentsData is List) {
      parsedStudentIds = List<String>.from(
        studentsData
            .where((item) => item != null)
            .map((item) => item.toString().trim())
            .where((id) => id.isNotEmpty),
      );
    }

    // --- Parsing des Projets ---
    List<ProjectModel> parsedProjects = [];
    final dynamic projectsData = json['projects']; // Récupérer les projets

    if (projectsData is List) {
      parsedProjects = projectsData
          .where((projectJson) => projectJson is Map<String, dynamic>) // S'assurer que chaque item est une Map
          .map((projectJson) => ProjectModel.fromJson(projectJson as Map<String, dynamic>))
          .toList();
    }
    // Si projectsData n'est pas une liste (ou est null), parsedProjects restera []

    return StudentBatchModel(
      studentBatchId: json['id']?.toString() ?? '', // Ou lever une erreur si l'ID est crucial
      studentBatchName: json['name']?.toString() ?? '', // Ou lever une erreur si le nom est crucial
      studentBatchState: json['state'] as String?,
      studentBatchTags: parsedTags,
      studentIds: parsedStudentIds,
      projects: parsedProjects,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': studentBatchId,
      'state': studentBatchState,
      'name': studentBatchName,
      'tags': studentBatchTags,
      'students': studentIds,
      'projects': projects.map((project) => project.toJson()).toList(),
    };
  }
}