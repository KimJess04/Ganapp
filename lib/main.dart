import 'package:flutter/material.dart';

// Importar todas las pantallas
import 'screens/dashboard_screen.dart';
import 'screens/animal_list.dart';
import 'screens/animal_register.dart';
import 'screens/government_aids.dart';
import 'screens/settings_screen.dart';
import 'screens/category_screen.dart';
import 'screens/sale_transfer.dart';
import 'screens/vaccines_screen.dart';
import 'screens/animal_detail.dart';
import 'screens/login_screen.dart'; // Pantalla de inicio de sesión
import 'screens/register_screen.dart'; // Pantalla de registro

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GanApp',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login', // Inicia en la pantalla de login
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/animales': (context) => const AnimalListScreen(),
        '/registrar': (context) => const AnimalRegisterScreen(),
        '/apoyos': (context) => const GovernmentAidsScreen(),
        '/perfil': (context) => const SettingsScreen(),
        '/engorda': (context) => CategoryScreen(category: 'Engorda'),
        '/vacas': (context) => CategoryScreen(category: 'Vacas'),
        '/toros': (context) => CategoryScreen(category: 'Toros'),
        '/lecheras': (context) => CategoryScreen(category: 'V. Lecheras'),
        '/detalle': (context) {
          final id = ModalRoute.of(context)!.settings.arguments as String;
          return AnimalDetailScreen(animalId: id);
        },
        '/vender': (context) => SaleTransferScreen(isSale: true),
        '/traspaso': (context) => SaleTransferScreen(isSale: false),
        '/vacunacion': (context) => const VaccinesScreen(),
      },
      onGenerateRoute: (settings) {
        // Manejo de rutas no definidas
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Página no encontrada')),
          ),
        );
      },
    );
  }
}