import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categoría: $category'),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[200], // Fondo claro para el ícono
            child: Image.asset(
              'assets/icons/huellaVaca.png', // Ícono personalizado
              color: Colors.purple, // Color opcional si el ícono lo permite
              width: 24, // Ancho del ícono
              height: 24, // Altura del ícono
            ),
          ),
          title: Text('Animal ${index + 1}'),
          subtitle: Text('Raza: Angus • Edad: ${index + 2} años'),
          onTap: () => Navigator.pushNamed(
            context,
            '/detalle',
            arguments: (index + 1).toString(),
          ),
        ),
      ),
    );
  }
}