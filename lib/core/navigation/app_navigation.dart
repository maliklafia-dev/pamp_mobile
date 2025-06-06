import 'package:flutter/material.dart';
import '../../features/notations/view/pages/notations_placeholder_page.dart';
import '../../features/projects/view/pages/project_page.dart';
import '../../features/teacher_auth/view/pages/teacher_profile_page.dart';

class AppNavigation {
  static void navigateToProjects(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const ProjectsPage()),
          (route) => false,
    );
  }

  static void navigateToNotations(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NotationsPlaceholderPage()),
    );
  }

  static void navigateToTeacherProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TeacherProfilePage()),
    );
  }
}
