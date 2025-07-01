import 'package:flutter/material.dart';

class VaccineAlertsScreen extends StatelessWidget {
  const VaccineAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alertas de Vacunas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Próximas vacunas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
                  ),
                ),
                Switch(value: true, onChanged: (value) {}),
                const Text('Notificaciones'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => _buildAlertItem(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertItem(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple.shade100,
          child: const Icon(Icons.warning, color: Colors.purple),
        ),
        title: Text('Vacuna próxima para Betsy'),
        subtitle: Text('Fecha: ${index + 20}/06/2023 - Tipo: Fiebre aftosa'),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.purple),
          onSelected: (value) {},
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Editar recordatorio')),
            const PopupMenuItem(value: 'cancel', child: Text('Cancelar alerta')),
          ],
        ),
      ),
    );
  }
}