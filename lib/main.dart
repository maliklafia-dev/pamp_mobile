import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/theme.dart';
import 'features/auth/view/pages/login.dart';
import 'features/auth/viewmodel/auth_viewmodel.dart';
import 'features/deliverables/viewmodel/deliverable_viewmodel.dart';
import 'features/projects/viewmodel/project_viewmodel.dart';
import 'features/reports/viewmodel/reports_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProjectsViewModel()),
          ChangeNotifierProvider(create: (_) => DeliverablesViewModel()),
          ChangeNotifierProvider(create: (_) => ReportsViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          home: const LoginPage(),
      )
    );
  }
}

class NotesViewModel {
}
