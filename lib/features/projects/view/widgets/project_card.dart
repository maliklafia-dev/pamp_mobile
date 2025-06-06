import 'package:flutter/material.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../deliverables/view/pages/deliverable_page.dart';
import '../../../reports/view/pages/reports_page.dart';

class ProjectCard extends StatelessWidget {
  final String promotion;
  final String projectName;
  final String deadline;
  final bool hasDeliverables;

  const ProjectCard({
    super.key,
    required this.promotion,
    required this.projectName,
    required this.deadline,
    this.hasDeliverables = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  projectName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportsPage(
                          promotion: promotion,
                          projectName: projectName,
                          deadline: deadline,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.yellow,
                    foregroundColor: AppPalette.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    minimumSize: const Size(0, 0),
                  ),
                  child: const Text('View Reports'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Deadline : $deadline',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                if (hasDeliverables)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeliverablesPage(
                            promotion: promotion,
                            projectName: projectName,
                            deadline: deadline,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.purple,
                      foregroundColor: AppPalette.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      minimumSize: const Size(0, 0),
                    ),
                    child: const Text('View Deliverables'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
