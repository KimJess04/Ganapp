import 'package:flutter/material.dart';

class GovernmentAidsScreen extends StatelessWidget {
  const GovernmentAidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Apoyos Gubernamentales')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('Apoyo ${index + 1}'),
            subtitle: const Text('Descripción breve del apoyo...'),
            trailing: const Icon(Icons.info_outline),
            onTap: () => _showAidDetails(context, index),
          ),
        ),
      ),
    );
  }

  void _showAidDetails(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detalles del Apoyo ${index + 1}'),
        content: const Text('Información detallada del apoyo...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}