import 'package:flutter/material.dart';

class AnimalListScreen extends StatelessWidget {
  const AnimalListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Animales'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          leading: const CircleAvatar(child: Icon(Icons.pets)),
          title: Text('Animal ${index + 1}'),
          subtitle: Text('Raza: Angus • Edad: ${index + 2} años'),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () => Navigator.pushNamed(
            context,
            '/detalle',
            arguments: (index + 1).toString()
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/registrar'),
        child: const Icon(Icons.add),
      ),
    );
  }
}