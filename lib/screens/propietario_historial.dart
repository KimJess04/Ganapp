import 'package:flutter/material.dart';

class PropietarioHistorialScreen extends StatelessWidget {
  const PropietarioHistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Propietario Historial'),
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
          _buildInputField('Comprobante', Icons.person),
          _buildInputField('Tipo de transferencia', Icons.swap_horiz),
          _buildDateField('Fecha de transferencia'),
          const Spacer(),
          ElevatedButton(
            onPressed: () => _showConfirmation(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Registrar historial'),
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
            itemBuilder: (context, index) => _buildTransferItem(index),
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
  Widget _buildInputField(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.purple),
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

  // Elemento de lista para el historial
  Widget _buildTransferItem(int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Image.asset(
          'assets/icons/transferencia.png', // Ícono personalizado
          color: Colors.purple, // Color opcional si el ícono lo permite
          width: 24, // Ancho del ícono
          height: 24, // Altura del ícono
        ),
        title: Text('Transferencia ${index + 1}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Animal: Betsy'),
            Text('Fecha: ${index + 15}/05/2023'),
            Text('Tipo: Transferencia interna'),
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
  void _showConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Registro'),
        content: const Text('¿Estás seguro de registrar este historial?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Historial registrado exitosamente')),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}