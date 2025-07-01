import 'package:flutter/material.dart';

class VaccinesScreen extends StatelessWidget {
  const VaccinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Control de Vacunas'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Registrar', icon: Icon(Icons.add_circle)),
              Tab(text: 'Historial', icon: Icon(Icons.history)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildRegisterTab(context),
            _buildHistoryTab(context),
          ],
        ),
      ),
    );
  }

  // Pestaña "Registrar"
  Widget _buildRegisterTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildAnimalSelector(),
          const SizedBox(height: 16),
          _buildInputField('Tipo de vacuna', 'assets/icons/vacuna.png'), // Ícono personalizado
          _buildDateField('Fecha de aplicación'),
          _buildDateField('Próxima aplicación'),
          const SizedBox(height: 16),
          _buildNotesField(),
          const Spacer(),
          ElevatedButton(
            onPressed: () => _showVaccineConfirmation(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Registrar Vacuna'),
          ),
        ],
      ),
    );
  }

  // Pestaña "Historial"
  Widget _buildHistoryTab(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Buscar en historial',
                    prefixIcon: Icon(Icons.search, color: Colors.purple),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.purple),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => _buildVaccineItem(index),
          ),
        ),
      ],
    );
  }

  // Selector de animal
  Widget _buildAnimalSelector() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Seleccionar animal',
        prefixIcon: Image.asset(
          'assets/icons/huellaVaca.png', // Ícono personalizado
          color: Colors.purple, // Color opcional si el ícono lo permite
          width: 24, // Ancho del ícono
          height: 24, // Altura del ícono
        ),
        border: const OutlineInputBorder(),
      ),
      items: ['Betsy', 'Toro 1', 'Vaca 2'].map((animal) {
        return DropdownMenuItem(value: animal, child: Text(animal));
      }).toList(),
      onChanged: (value) {},
    );
  }

  // Campo de entrada con ícono
  Widget _buildInputField(String label, dynamic icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon is IconData
              ? Icon(icon, color: Colors.purple)
              : Image.asset(
                  icon,
                  color: Colors.purple, // Color opcional si el ícono lo permite
                  width: 24, // Ancho del ícono
                  height: 24, // Altura del ícono
                ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // Campo de fecha con ícono
  Widget _buildDateField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today, color: Colors.purple),
          border: const OutlineInputBorder(),
        ),
        onTap: () async {
          // Lógica para seleccionar fecha
        },
      ),
    );
  }

  // Campo de notas adicionales
  Widget _buildNotesField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Notas adicionales',
        prefixIcon: Icon(Icons.note, color: Colors.purple),
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }

  // Elemento de lista para el historial
  Widget _buildVaccineItem(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.asset(
          'assets/icons/vacuna.png', // Ícono personalizado
          color: Colors.purple, // Color opcional si el ícono lo permite
          width: 24, // Ancho del ícono
          height: 24, // Altura del ícono
        ),
        title: Text('Vacuna ${index + 1}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Animal: Betsy'),
            Text('Fecha: ${index + 15}/05/2023'),
            Text('Próxima: ${index + 15}/11/2023'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.notifications_active, color: Colors.purple),
          onPressed: () {},
        ),
      ),
    );
  }

  // Confirmación de registro
  void _showVaccineConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Registro de Vacuna'),
        content: const Text('¿Estás seguro de registrar esta vacuna?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Vacuna registrada exitosamente')),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}