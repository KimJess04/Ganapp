import 'package:flutter/material.dart';

class SaleTransferScreen extends StatelessWidget {
  final bool isSale;

  const SaleTransferScreen({super.key, required this.isSale});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isSale ? 'Registro de Ventas' : 'Registro de Traspasos'),
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
          _buildInputField('Comprador', Icons.person),
          if (isSale) _buildInputField('Precio', Icons.attach_money, keyboardType: TextInputType.number),
          _buildDateField('Fecha de venta'),
          const Spacer(),
          ElevatedButton(
            onPressed: () => _showConfirmation(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(isSale ? 'Registrar Venta' : 'Registrar Traspaso'),
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
        prefixIcon: Icon(Icons.pets, color: Colors.purple), // Reemplazamos Image.asset
        border: const OutlineInputBorder(),
      ),
      items: ['Betsy', 'Toro 1', 'Vaca 2'].map((animal) {
        return DropdownMenuItem(value: animal, child: Text(animal));
      }).toList(),
      onChanged: (value) {},
    );
  }

  // Campo de entrada con ícono
  Widget _buildInputField(String label, IconData icon, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.purple),
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
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
        leading: Icon(Icons.transfer_within_a_station, color: Colors.purple), // Reemplazamos Image.asset
        title: Text(isSale ? 'Venta ${index + 1}' : 'Traspaso ${index + 1}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Animal: Betsy'),
            Text('Fecha: ${index + 15}/05/2023'),
            Text('Comprador: Juan Pérez'),
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
        title: Text(isSale ? 'Confirmar Venta' : 'Confirmar Traspaso'),
        content: Text('¿Estás seguro de registrar este ${isSale ? 'venta' : 'traspaso'}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${isSale ? 'Venta' : 'Traspaso'} registrado exitosamente')),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}