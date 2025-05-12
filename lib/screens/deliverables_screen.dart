import 'package:flutter/material.dart';
import '../models/Deliverable.dart';
import '../services/api_service.dart';

class DeliverablesScreen extends StatefulWidget {
  @override
  _DeliverablesScreenState createState() => _DeliverablesScreenState();
}

class _DeliverablesScreenState extends State<DeliverablesScreen> {
  late Future<List<Deliverable>> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.fetchDeliverables();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Livrables')),
      body: FutureBuilder<List<Deliverable>>(
        future: _future,
        builder: (c, snap) {
          if (snap.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
          if (snap.hasError) return Center(child: Text('Erreur : ${snap.error}'));
          final items = snap.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, i) => ListTile(
              title: Text(items[i].title),
              subtitle: Text('Deadline: ${items[i].deadline}'),
            ),
          );
        },
      ),
    );
  }
}