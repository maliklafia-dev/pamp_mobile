import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../deliverables/view/pages/deliverable_page.dart'; // Pour la navigation vers la page des livrables
import '../../../reports/view/pages/reports_page.dart';       // Pour la navigation vers la page des rapports
import '../../models/project_model.dart'; // <<< IMPORTER PROJECT MODEL POUR AVOIR ACCÈS AUX GROUPES

class ProjectCard extends StatelessWidget {
  final String promotion;
  final ProjectModel project; // <<< MODIFIER POUR PASSER L'OBJET PROJET COMPLET
  final String deadline; // Garder pour l'instant, ou dériver de project.projectCreatedAt si redondant

  // hasDeliverables n'est plus directement nécessaire ici si on se base sur les groupes
  // final bool hasDeliverables;

  const ProjectCard({
    super.key,
    required this.promotion,
    required this.project, // <<< MODIFIER
    required this.deadline,
    // this.hasDeliverables = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligner le contenu de la colonne à gauche
          children: [
            // --- Section Informations Projet ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded( // Pour que le nom du projet puisse prendre de la place et faire un wrap si besoin
                  child: Text(
                    project.projectName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16, // Un peu plus grand pour le nom du projet
                    ),
                    overflow: TextOverflow.ellipsis, // Gérer les noms de projet longs
                  ),
                ),
                // Ce bouton pourrait être général au projet ou spécifique si l'API le permet
                ElevatedButton(
                  onPressed: () {
                    // Naviguer vers une page de détails du projet ou rapports généraux du projet
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportsPage( // Ou une page de détails du projet
                          promotion: promotion,
                          projectName: project.projectName,
                          deadline: deadline, // ou project.projectCreatedAt si pertinent
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.yellow,
                    foregroundColor: AppPalette.black,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    minimumSize: const Size(0, 0),
                  ),
                  child: const Text('Rapports Projet'), // Texte plus générique
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Deadline : $deadline', // ou formater project.projectCreatedAt
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),

            // --- Section Groupes et Leurs Livrables/Rapports ---
            if (project.groups.isNotEmpty) ...[ // Si le projet a des groupes
              const Text(
                'Groupes et Livrables :',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true, // Important dans un Column
                physics: const NeverScrollableScrollPhysics(), // Important dans un Column
                itemCount: project.groups.length,
                itemBuilder: (context, groupIndex) {
                  final group = project.groups[groupIndex];
                  final reportStatus = group.reportSubmitted == true
                      ? 'Soumis'
                      : (group.reportSubmitted == false ? 'Non soumis' : 'Statut inconnu');
                  final reportDate = group.reportSubmittedDate != null
                      ? DateFormat('dd/MM/yy HH:mm').format(group.reportSubmittedDate!)
                      : '';

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${group.groupName}: $reportStatus ${group.reportSubmitted == true && reportDate.isNotEmpty ? '($reportDate)' : ''}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        // Bouton pour voir le livrable/rapport spécifique du groupe
                        // Vous aurez besoin d'un endpoint/logique pour cela
                        ElevatedButton(
                          onPressed: () {
                            // Naviguer vers la page des livrables pour ce groupe spécifique
                            // Vous aurez besoin de l'ID du groupe et potentiellement de l'ID du projet
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeliverablesPage(
                                  // Passez les infos nécessaires à DeliverablesPage
                                  // par exemple: projectId: project.projectId, groupId: group.groupId
                                  promotion: promotion, // Garder si utile pour le contexte
                                  projectName: project.projectName, // Garder si utile
                                  groupName: group.groupName,
                                  deadline: deadline, // Ou une deadline spécifique au livrable
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppPalette.purple,
                            foregroundColor: AppPalette.white,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                            minimumSize: const Size(0, 0),
                          ),
                          child: const Text('Voir Livrable'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ] else ...[
              const Text(
                'Aucun groupe défini pour ce projet.',
                style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
              ),
            ],
            const SizedBox(height: 8), // Espace en bas de la carte
          ],
        ),
      ),
    );
  }
}