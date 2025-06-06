import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_pallete.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/bottom_navigation_widget.dart';
import '../../../objectives/view/pages/objectives_pages.dart';
import '../../../students_promotions/viewmodel/student_batch_viewmodel.dart';
import '../../viewmodel/project_management_viewmodel.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudentBatchViewModel>(context, listen: false).fetchAllStudentBatches();
      Provider.of<ProjectManagementViewModel>(context, listen: false).fetchAllProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projets'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ObjectivesPage()),
            );
          },
        ),
      ),
      body: Consumer2<StudentBatchViewModel, ProjectManagementViewModel>(
        builder: (context, batchViewModel, projectViewModel, child) {
          if (batchViewModel.isLoadingStudentBatches || projectViewModel.isLoadingProjects) {
            return const Center(child: CircularProgressIndicator());
          }

          if (batchViewModel.studentBatchError != null || projectViewModel.projectError != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    batchViewModel.studentBatchError ?? projectViewModel.projectError ?? 'Une erreur est survenue',
                    style: const TextStyle(color: AppPalette.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      batchViewModel.fetchAllStudentBatches();
                      projectViewModel.fetchAllProjects();
                    },
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          final studentBatches = batchViewModel.studentBatches;
          final allProjects = projectViewModel.projects;

          if (studentBatches.isEmpty) {
            return const Center(
              child: Text('Aucune promotion trouvée'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: studentBatches.length,
            itemBuilder: (context, index) {
              final batch = studentBatches[index];
              final batchProjects = allProjects
                  .where((project) => project.linkedStudentBatchId == batch.studentBatchId)
                  .toList();

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      batch.studentBatchName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (batchProjects.isEmpty)
                      Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Aucun projet pour cette promotion',
                            style: TextStyle(
                              color: AppPalette.darkGrey.withOpacity(0.7),
                            ),
                          ),
                        ),
                      )
                    else
                      ...batchProjects.map((project) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ProjectCard(
                          promotion: batch.studentBatchName,
                          projectName: project.projectName,
                          deadline: project.projectCreatedAt != null
                              ? DateFormat('dd/MM/yy').format(project.projectCreatedAt!)
                              : 'Non définie',
                          hasDeliverables: true,
                        ),
                      )),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNavigationWidget(currentIndex: 1),
    );
  }
}
