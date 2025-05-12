import 'package:flutter/material.dart';
import '../models/Rubric.dart';
import '../services/api_service.dart';

class RubricsScreen extends StatefulWidget {
  @override
  _RubricsScreenState createState() => _RubricsScreenState();
}

class _RubricsScreenState extends State<RubricsScreen> {
  late Future<List<Rubric>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchRubrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notation')),
      body: FutureBuilder<List<Rubric>>(
        future: _future,
        builder: (c, snap) {
          if (snap.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snap.hasError) return Center(child: Text('Erreur : ${snap.error}'));
          final rubrics = snap.data!;
          return ListView.builder(
            itemCount: rubrics.length,
            itemBuilder: (_, i) {
              final r = rubrics[i];
              return ExpansionTile(
                title: Text(r.title),
                children: r.criteria.map((c) => ListTile(
                  title: Text(c.name),
                  trailing: DropdownButton<int>(value: c.score, items: List.generate(11, (i)=> DropdownMenuItem(value: i, child: Text('$i'))), onChanged: (v) => setState(() => c.score = v!)),
                )).toList(),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async { await ApiService.submitScores(); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notes enregistrées'))); },
        child: Icon(Icons.save),
      ),
    );
  }
}