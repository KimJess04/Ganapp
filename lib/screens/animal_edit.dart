import 'package:flutter/material.dart';
import 'animal_detail.dart';

class AnimalEditScreen extends StatelessWidget {
  const AnimalEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Animal'),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/vacuna.png', // Ícono personalizado
              width: 24, // Ancho del ícono
              height: 24, // Altura del ícono
            ),
            onPressed: () => _showHistory(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildEditableField('Nombre', 'Betsy', Icons.abc),
            _buildEditableField('Raza', 'Angus', Icons.pets),
            _buildEditableField('Edad', '3 años', Icons.calendar_today),
            _buildDropdown('Categoría', ['Cría', 'Engorda', 'Reproducción'], 'Engorda'),
            const Spacer(),
            ElevatedButton(
              onPressed: () => _showUpdateConfirmation(context),
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.purple),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String currentValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(Icons.category, color: Colors.purple),
          border: OutlineInputBorder(),
        ),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: (value) {},
      ),
    );
  }

  void _showHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Historial de Cambios'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHistoryItem('15/05/2023', 'Cambió categoría a Engorda'),
            _buildHistoryItem('10/04/2023', 'Actualización de peso'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String date, String change) {
    return ListTile(
      leading: Image.asset(
        'assets/icons/vacuna.png', // Ícono personalizado
        width: 24, // Ancho del ícono
        height: 24, // Altura del ícono
        color: Colors.purple, // Color opcional si el ícono lo permite
      ),
      title: Text(change),
      subtitle: Text(date),
    );
  }

  void _showUpdateConfirmation(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cambios guardados exitosamente')),
    );
    Navigator.pop(context);
  }
}