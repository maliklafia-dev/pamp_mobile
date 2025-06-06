import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/bottom_navigation_widget.dart';
import '../../../teacher_auth/view/pages/login_page.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../viewmodel/teacher_authentication_viewmodel.dart';

class TeacherProfilePage extends StatelessWidget {
  const TeacherProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<TeacherAuthenticationViewModel>(context);
    final teacher = authViewModel.authenticatedTeacher;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
      ),
      body: teacher == null
          ? const Center(
        child: Text('Aucun profil enseignant trouvé'),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo de profil
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppPalette.yellow,
                backgroundImage: teacher.teacherPhotoUrl != null
                    ? NetworkImage(teacher.teacherPhotoUrl!)
                    : null,
                child: teacher.teacherPhotoUrl == null
                    ? Text(
                  teacher.teacherFullName.isNotEmpty
                      ? teacher.teacherFullName[0].toUpperCase()
                      : 'T',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppPalette.black,
                  ),
                )
                    : null,
              ),
            ),
            const SizedBox(height: 24),

            // Informations du profil
            _buildProfileInfo('Nom complet', teacher.teacherFullName),
            _buildProfileInfo('Email', teacher.teacherEmail),
            if (teacher.teacherRole != null)
              _buildProfileInfo('Rôle', teacher.teacherRole!),

            const Spacer(),

            // Bouton de déconnexion
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: authViewModel.isAuthenticating
                    ? null
                    : () async {
                  await authViewModel.logoutTeacher();
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                          (route) => false,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.red,
                  foregroundColor: AppPalette.white,
                ),
                child: authViewModel.isAuthenticating
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppPalette.white,
                  ),
                )
                    : const Text('Se déconnecter'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationWidget(currentIndex: 2),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppPalette.darkGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: AppPalette.black,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
