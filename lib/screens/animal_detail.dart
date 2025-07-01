import 'package:flutter/material.dart';

class AnimalDetailScreen extends StatelessWidget {
  final String animalId;

  const AnimalDetailScreen({super.key, required this.animalId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Animal $animalId'),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/icons/huellaVaca.png', // Ícono personalizado
              color: Colors.purple, // Color opcional si el ícono lo permite
              width: 24, // Ancho del ícono
              height: 24, // Altura del ícono
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Nombre', 'Animal $animalId'),
            _buildDetailRow('Raza', 'Angus'),
            _buildDetailRow('Edad', '${int.parse(animalId) + 2} años'),
            _buildDetailRow('Categoría', 'Vaca lechera'),
            const Divider(),
            const Text('Historial de vacunas', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildVaccineItem('Fiebre aftosa', '15/05/2023'),
            _buildVaccineItem('Brucelosis', '20/06/2023'),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton('Editar', Icons.edit, () {}),
                _buildActionButton('Eliminar', Icons.delete, () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Animal eliminado')),
                  );
                }),
                _buildActionButton('Vacunar', 'assets/icons/vacuna.png', () {
                  Navigator.pushNamed(context, '/vacunacion');
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildVaccineItem(String vaccine, String date) {
    return ListTile(
      leading: Image.asset(
        'assets/icons/vacuna.png', // Ícono personalizado
        color: Colors.purple, // Color opcional si el ícono lo permite
        width: 24, // Ancho del ícono
        height: 24, // Altura del ícono
      ),
      title: Text(vaccine),
      subtitle: Text(date),
    );
  }

  Widget _buildActionButton(String label, dynamic icon, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: icon is IconData
              ? Icon(icon, color: Colors.purple)
              : Image.asset(
                  icon,
                  color: Colors.purple, // Color opcional si el ícono lo permite
                  width: 24, // Ancho del ícono
                  height: 24, // Altura del ícono
                ),
          onPressed: onPressed,
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}