import 'package:flutter/material.dart';
import '../navigation/app_navigation.dart';

class BottomNavigationWidget extends StatelessWidget {
  final int currentIndex;

  const BottomNavigationWidget({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTabTapped(context, index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_note),
          label: 'Notations',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.folder),
          label: 'Projets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
    );
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        AppNavigation.navigateToNotations(context);
        break;
      case 1:
        AppNavigation.navigateToProjects(context);
        break;
      case 2:
        AppNavigation.navigateToTeacherProfile(context);
        break;
    }
  }
}
