import 'package:flutter/material.dart';
class ObjectivesPage extends StatelessWidget {
  const ObjectivesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Objectifs de l\'app mobile:'),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ObjectiveItem(text: 'voir les projets et les noter,'),
            ObjectiveItem(text: 'suivre les livrables,'),
            ObjectiveItem(text: 'lire les rapports'),
          ],
        ),
      ),
    );
  }
}

class ObjectiveItem extends StatelessWidget {
  final String text;

  const ObjectiveItem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
