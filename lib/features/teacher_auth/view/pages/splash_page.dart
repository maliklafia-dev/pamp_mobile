import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../teacher_auth/view/pages/login_page.dart';
import '../../../../core/theme/app_pallete.dart';
import '../../../projects/view/pages/project_page.dart';
import '../../viewmodel/teacher_authentication_viewmodel.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkAuthStatus();
      }
    });
  }

  Future<void> _checkAuthStatus() async {
    final authViewModel = Provider.of<TeacherAuthenticationViewModel>(context, listen: false);
    await authViewModel.checkTeacherAuthenticationStatus();

    if (mounted) {
      if (authViewModel.isTeacherAuthenticated) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ProjectsPage()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppPalette.yellow,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 48,
                color: AppPalette.black,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'PAMP',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppPalette.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Teacher Dashboard',
              style: TextStyle(
                fontSize: 16,
                color: AppPalette.darkGrey,
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(
              color: AppPalette.yellow,
            ),
          ],
        ),
      ),
    );
  }
}