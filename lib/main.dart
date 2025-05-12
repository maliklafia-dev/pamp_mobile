import 'package:flutter/material.dart';
import 'screens/deliverables_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/rubrics_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion Projets Étudiants - Mobile',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _screens = [
    DeliverablesScreen(),
    ReportsScreen(),
    RubricsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.upload_file), label: 'Livrables'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Rapports'),
          BottomNavigationBarItem(icon: Icon(Icons.rate_review), label: 'Notation'),
        ],
      ),
    );
  }
}