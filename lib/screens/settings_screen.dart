import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionHeader('Preferencias'),
          _buildSettingItem('Notificaciones', Icons.notifications, () {}),
          _buildSettingItem('Tema', Icons.color_lens, () {}),
          _buildSettingItem('Idioma', Icons.language, () {}),
          const Divider(),
          _buildSectionHeader('Catálogos'),
          _buildSettingItem('Razas', 'assets/icons/huellaVaca.png', () {}), // Ícono personalizado
          _buildSettingItem('Categorías', Icons.category, () {}),
          _buildSettingItem('Tipos de vacunas', 'assets/icons/vacuna.png', () {}), // Ícono personalizado
          const Divider(),
          _buildSectionHeader('Cuenta'),
          _buildSettingItem('Sincronizar datos', Icons.sync, () {}),
          _buildSettingItem('Cerrar sesión', Icons.logout, () {}),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'GanApp v1.0.0',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple),
      ),
    );
  }

  Widget _buildSettingItem(String title, dynamic icon, VoidCallback onTap) {
    return ListTile(
      leading: icon is IconData
          ? Icon(icon, color: Colors.purple)
          : Image.asset(
              icon,
              color: Colors.purple, // Color opcional si el ícono lo permite
              width: 24, // Ancho del ícono
              height: 24, // Altura del ícono
            ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.purple),
      onTap: onTap,
    );
  }
}