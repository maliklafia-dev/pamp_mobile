import 'package:flutter/material.dart';
import '../models/Report.dart';
import '../services/api_service.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rapports')),
      body: FutureBuilder<List<Report>>(
        future: ApiService.fetchReports(),
        builder: (c, snap) {
          if (snap.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snap.hasError) return Center(child: Text('Erreur : ${snap.error}'));
          final list = snap.data!;
          return ListView(
            children: list.map((r) => ListTile(
              title: Text(r.title),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ReportViewer(report: r))),
            )).toList(),
          );
        },
      ),
    );
  }
}

class ReportViewer extends StatelessWidget {
  final Report report;
  ReportViewer({required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(report.title)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(child: Text(report.content)),
      ),
    );
  }
}