import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Map<String, String> userData = {
    'name': 'Juan Pérez',
    'email': 'juan@example.com',
    'role': 'Administrador',
  };

  String _getIconPath(String categoryName) {
    switch (categoryName) {
      case 'Engorda':
        return 'assets/icons/engorda.png';
      case 'Vacas':
        return 'assets/icons/vaca.png';
      case 'Toros':
        return 'assets/icons/toro.png';
      case 'V. Lecheras':
        return 'assets/icons/vacaLechera.png';
      default:
        return 'assets/icons/huellaVaca.png';
    }
  }

  List<Map<String, dynamic>> categoryCounts = [
    {'name': 'Engorda', 'count': 12},
    {'name': 'Vacas', 'count': 8},
    {'name': 'Toros', 'count': 5},
    {'name': 'V. Lecheras', 'count': 7},
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _loadCategories(context));
  }

  void _loadCategories(BuildContext context) async {
    try {
      setState(() {
        categoryCounts = [
          {'name': 'Engorda', 'count': 12},
          {'name': 'Vacas', 'count': 8},
          {'name': 'Toros', 'count': 5},
          {'name': 'V. Lecheras', 'count': 7},
        ];
      });
    } catch (e) {
      print('Error al cargar las categorías');
      setState(() {
        categoryCounts = [
          {'name': 'Engorda', 'count': 0},
          {'name': 'Vacas', 'count': 0},
          {'name': 'Toros', 'count': 0},
          {'name': 'V. Lecheras', 'count': 0},
        ];
      });
    }
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  Widget _buildCategoryCard(BuildContext context, String name, int count) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/$name'),
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.purple.shade100,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.purple.shade300, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _getIconPath(name),
              color: Colors.purple,
              width: 32,
              height: 32,
              errorBuilder: (_, __, ___) => const Icon(Icons.error, color: Colors.red),
            ),
            const SizedBox(height: 4),
            Text(name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.purple)),
            Text('($count)', style: const TextStyle(color: Colors.purple, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, String title, String subtitle, String route, String id) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route, arguments: id),
      child: Card(
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            color: Colors.grey[200],
            child: Image.asset('assets/icons/huellaVaca.png', color: Colors.purple),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(BuildContext context, String title, dynamic icon, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.purple.shade100,
            child: icon is IconData
                ? Icon(icon, color: Colors.purple, size: 24)
                : Image.asset(icon, color: Colors.purple, width: 24, height: 24),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildQuickMenuButton(BuildContext context, String title, IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(icon, color: Colors.purple, size: 24),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  void _showNotificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notificaciones'),
        content: Container(
          constraints: const BoxConstraints(maxHeight: 300),
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(3, (index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Apoyo de semental', style: TextStyle(fontWeight: FontWeight.bold)),
                            Chip(label: Text('ACTIVO'), backgroundColor: Colors.greenAccent),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('Se dará un apoyo del 50% para comprar un semental de registro',
                            style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 8),
                        const Text('05-06-2025', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
        ],
      ),
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Apoyos'),
        content: Container(
          constraints: const BoxConstraints(maxHeight: 300),
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(2, (index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Apoyo de semental', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text('SAGARPA', style: TextStyle(fontStyle: FontStyle.italic)),
                        const SizedBox(height: 4),
                        const Text('Cada ganadero tendrá un apoyo del 50%.', style: TextStyle(fontSize: 12)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('fecha inicio: 05-06-2025', style: TextStyle(fontSize: 12)),
                                  SizedBox(height: 4),
                                  Text('fecha final: 05-08-2025', style: TextStyle(fontSize: 12)),
                                  SizedBox(height: 4),
                                  Text('requisitos: UTP', style: TextStyle(fontSize: 12)),
                                  SizedBox(height: 4),
                                  Text('SAGARPA@gmail.com', style: TextStyle(fontSize: 12)),
                                  SizedBox(height: 4),
                                  Text('Activo', style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              icon: const Icon(Icons.print, color: Colors.purple),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
        ],
      ),
    );
  }

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mi Cuenta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: Text('Nombre: ${userData['name']}')),
            ListTile(title: Text('Correo: ${userData['email']}')),
            ListTile(title: Text('Rol: ${userData['role']}')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cerrar')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => _logout(context)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text("Descripción General", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categoryCounts.map((category) {
                  return _buildCategoryCard(context, category['name'], category['count']);
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Actividades Recientes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                children: [
                  _buildActivityCard(context, "Nueva Compra", "Arete #1234, 500kg", '/detalle', '1234'),
                  _buildActivityCard(context, "Actualización de vacuna", "Arete #5678, Prox: 12/12", '/detalle', '5678'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text("Acciones Rápidas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickActionButton(context, "Registrar", Icons.add, '/registrar'),
                _buildQuickActionButton(context, "Animales", Icons.list, '/animales'),
                _buildQuickActionButton(context, "Vender", Icons.shopping_cart, '/vender'),
                _buildQuickMenuButton(context, "Vacunación", Icons.vaccines, () {
                  Navigator.pushNamed(context, '/vacunacion');
                }),
                _buildQuickActionButton(context, "Reportes", Icons.download, '/perfil'),
              ],
            ),
            const Divider(),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickMenuButton(context, "Inicio", Icons.home, () {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                }),
                _buildQuickMenuButton(context, "Notificaciones", Icons.inbox, () {
                  _showNotificationDialog(context);
                }),
                _buildQuickMenuButton(context, "Añadir", Icons.add_box, () {
                  Navigator.pushNamed(context, '/registrar');
                }),
                _buildQuickMenuButton(context, "Apoyos", Icons.people, () {
                  _showSupportDialog(context);
                }),
                _buildQuickMenuButton(context, "Yo", Icons.person, () {
                  _showProfileDialog(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
