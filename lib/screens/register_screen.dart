import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoPaternoController = TextEditingController();
  final TextEditingController _apellidoMaternoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _cruzamientosController = TextEditingController();
  final TextEditingController _coloniaController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late String _tipoTelefono;
  late String _tipoEmail;
  late String _estado;
  late String _municipio;
  late String _localidad;


  // Datos estáticos para ejemplo
  final List<String> estados = [
    'Aguascalientes',
    'Baja California',
    'Baja California Sur',
    'Campeche',
    'Chiapas',
    'Chihuahua',
    'Ciudad de México',
    'Coahuila',
    'Colima',
    'Durango',
    'Guanajuato',
    'Guerrero',
    'Hidalgo',
    'Jalisco',
    'México',
    'Michoacán',
    'Morelos',
    'Nayarit',
    'Nuevo León',
    'Oaxaca',
    'Puebla',
    'Querétaro',
    'Quintana Roo',
    'San Luis Potosí',
    'Sinaloa',
    'Sonora',
    'Tabasco', // Estado seleccionado por defecto
    'Tamaulipas',
    'Tlaxcala',
    'Veracruz',
    'Yucatán',
    'Zacatecas'
  ];

  // Municipios por estado (ejemplo)
  late Map<String, List<String>> municipiosPorEstado = {
    'Tabasco': ['Centro', 'Balancán', 'Cárdenas'],
    'Nuevo León': ['Monterrey', 'San Nicolás', 'Apodaca'],
    'Ciudad de México': ['Álvaro Obregón', 'Cuauhtémoc', 'Miguel Hidalgo'],
  };

  // Localidades por municipio (ejemplo)
  late Map<String, List<String>> localidadesPorMunicipio = {
    'Centro': ['Centro', 'El Limón', 'Las Margaritas'],
    'Balancán': ['Balancán', 'La Trinitaria', 'San Juan'],
    'Cárdenas': ['Cárdenas', 'El Cenizo', 'El Paraíso'],
    'Monterrey': ['Centro', 'Valle Alto', 'San Pedro Garza García'],
    'San Nicolás': ['Centro', 'Los Robles', 'Del Prado'],
    'Apodaca': ['Centro', 'Parque Industrial', 'San Isidro'],
    'Álvaro Obregón': ['Centro', 'Villa Coapa', 'Mixcoac'],
    'Cuauhtémoc': ['Centro', 'Condesa', 'Juárez'],
    'Miguel Hidalgo': ['Centro', 'Polanco', 'Lomas de Chapultepec'],
  };

  final List<String> tiposTelefono = ['Celular', 'Casa', 'Trabajo'];
  final List<String> tiposEmail = ['Personal', 'Laboral'];

  @override
  void initState() {
    super.initState();
    _tipoTelefono = tiposTelefono.first;
    _tipoEmail = tiposEmail.first;
    _estado = 'Tabasco'; // Por defecto
    _municipio = municipiosPorEstado[_estado]!.first;
    _localidad = localidadesPorMunicipio[_municipio]?.first ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Usuario')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Datos Personales ===
              const Text('Datos Personales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildInputField(label: 'Nombre(s)', controller: _nombreController),
              _buildInputField(label: 'Apellido Paterno', controller: _apellidoPaternoController),
              _buildInputField(label: 'Apellido Materno', controller: _apellidoMaternoController),
              _buildInputField(label: 'Correo Electrónico', controller: _emailController),
              _buildInputField(label: 'Contraseña', controller: _passwordController, obscureText: true),
             
              const SizedBox(height: 20),
              // === Dirección ===
              const Text('Dirección', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildInputField(label: 'Calle', controller: _calleController),
              _buildInputField(label: 'Número', controller: _numeroController),
              _buildInputField(label: 'Cruzamientos / Referencias', controller: _cruzamientosController),
              _buildInputField(label: 'Colonia', controller: _coloniaController),
              _buildInputField(label: 'Código Postal', controller: _cpController),

              _buildDropdown(
                label: 'Estado',
                items: estados,
                value: _estado,
                onChanged: (value) {
                  setState(() {
                    _estado = value!;
                    _municipio = municipiosPorEstado[_estado]!.first;
                    _localidad = localidadesPorMunicipio[_municipio]!.first;
                  });
                },
              ),
              _buildDropdown(
                label: 'Municipio',
                items: municipiosPorEstado[_estado]!,
                value: _municipio,
                onChanged: (value) {
                  setState(() {
                    _municipio = value!;
                    _localidad = localidadesPorMunicipio[_municipio]!.first;
                  });
                },
              ),
              _buildDropdown(
                label: 'Localidad',
                items: localidadesPorMunicipio[_municipio]!,
                value: _localidad,
                onChanged: (value) {
                  setState(() {
                    _localidad = value!;
                  });
                },
              ),

              const SizedBox(height: 20),
              // === Contacto ===
              const Text('Contacto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              _buildDropdown(label: 'Tipo de Teléfono', items: tiposTelefono, value: _tipoTelefono, onChanged: (value) => setState(() => _tipoTelefono = value!)),
              _buildInputField(label: 'Teléfono', controller: _telefonoController),
              _buildDropdown(label: 'Tipo de Correo', items: tiposEmail, value: _tipoEmail, onChanged: (value) => setState(() => _tipoEmail = value!)),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Usuario registrado exitosamente')),
                    );
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                child: const Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(Icons.person, color: Colors.purple),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label es requerido';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDateField({required String label, required DateTime date}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        enabled: false,
        initialValue: "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.calendar_today, color: Colors.purple),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required List<T> items,
    required T value,
    required Function(T?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.location_city, color: Colors.purple), // Ícono para Municipio y Localidad
        ),
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? '$label es requerido' : null,
      ),
    );
  }
}