import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/deliverables/viewmodel/deliverable_viewmodel.dart';
import 'features/projects/viewmodel/project_management_viewmodel.dart';
import 'features/reports/viewmodel/reports_viewmodel.dart';
import 'features/students_promotions/viewmodel/student_batch_viewmodel.dart';
import 'features/teacher_auth/view/pages/splash_page.dart';
import 'features/teacher_auth/viewmodel/teacher_authentication_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TeacherAuthenticationViewModel()),
        ChangeNotifierProvider(create: (_) => StudentBatchViewModel()),
        ChangeNotifierProvider(create: (_) => ProjectManagementViewModel()),
        ChangeNotifierProvider(create: (_) => ReportsViewModel()),
        ChangeNotifierProvider(create: (_) => DeliverablesViewModel()),
      ],
      child: MaterialApp(
        title: 'PAMP - Teacher Dashboard',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashPage(),
      ),
    );
  }
}
