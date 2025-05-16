import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pamp_mobile/core/theme/app_pallete.dart';
import 'package:pamp_mobile/features/projects/viewmodel/project_viewmodel.dart';
import '../../../objectives/view/pages/objectives_pages.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  int _selectedIndex = 1; // Projects tab selected by default

  @override
  void initState() {
    super.initState();
    // Fetch projects when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProjectsViewModel>(context, listen: false).fetchProjects();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on the selected tab
    if (index == 0) {
      // Navigate to Notations
    } else if (index == 2) {
      // Navigate to Profile
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProjectsViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ObjectivesPage()),
              );
            },
          ),
        ],
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.error != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              viewModel.error!,
              style: const TextStyle(color: AppPalette.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                viewModel.fetchProjects();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: viewModel.projects.length,
        itemBuilder: (context, index) {
          final project = viewModel.projects[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ProjectCard(
              promotion: project.promotion,
              projectName: project.name,
              deadline: DateFormat('dd/MM/yy').format(project.deadline),
              hasDeliverables: project.hasDeliverables,
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: 'Notations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

