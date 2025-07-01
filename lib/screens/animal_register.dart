import 'package:flutter/material.dart';

class AnimalRegisterScreen extends StatefulWidget {
  const AnimalRegisterScreen({super.key});

  @override
  State<AnimalRegisterScreen> createState() => _AnimalRegisterScreenState();
}

class _AnimalRegisterScreenState extends State<AnimalRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _categoria;
  late String _raza;
  late String _sexo;
  late String _estadoSalud;

  DateTime? _fechaNacimiento;
  DateTime? _fechaRegistro;

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();
  final TextEditingController _areteController = TextEditingController();

  // Listas para selects
  final List<String> categorias = ['Novillo', 'Vaca', 'Ternero', 'Toros'];
  final List<String> razas = ['Holstein', 'Jersey', 'Brown Swiss', 'Ayrshire'];
  final List<String> sexos = ['Macho', 'Hembra'];
  final List<String> estadosSalud = ['Sano', 'Enfermo', 'En tratamiento'];

  @override
  void initState() {
    super.initState();
    _categoria = categorias.first;
    _raza = razas.first;
    _sexo = sexos.first;
    _estadoSalud = estadosSalud.first;
    _fechaRegistro = DateTime.now(); // Fecha por defecto
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _pesoController.dispose();
    _comentarioController.dispose();
    _areteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Animal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildDropdown<String>(
                label: 'Categoría',
                items: categorias,
                value: _categoria,
                onChanged: (value) => setState(() => _categoria = value!),
              ),
              _buildDropdown<String>(
                label: 'Raza',
                items: razas,
                value: _raza,
                onChanged: (value) => setState(() => _raza = value!),
              ),
              _buildInputField(label: 'Nombre', icon: Icons.abc, controller: _nombreController),
              _buildDateField(
                label: 'Fecha de Nacimiento',
                displayText: _fechaNacimiento?.toString().split(' ').first ?? 'Seleccionar fecha',
                onTap: () => _selectDate(context, (date) => setState(() => _fechaNacimiento = date)),
              ),
              _buildDropdown<String>(
                label: 'Sexo',
                items: sexos,
                value: _sexo,
                onChanged: (value) => setState(() => _sexo = value!),
              ),
              _buildInputField(label: 'Peso (kg)', icon: Icons.balance, keyboardType: TextInputType.number, controller: _pesoController),
              _buildDropdown<String>(
                label: 'Estado de Salud',
                items: estadosSalud,
                value: _estadoSalud,
                onChanged: (value) => setState(() => _estadoSalud = value!),
              ),
              _buildDateField(
                label: 'Fecha de Registro',
                displayText: _fechaRegistro?.toString().split(' ').first ?? 'Seleccionar fecha',
                onTap: () => _selectDate(context, (date) => setState(() => _fechaRegistro = date)),
              ),
              _buildCommentField(controller: _comentarioController),
              _buildPhotoField(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Animal registrado exitosamente')),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.purple),
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label es requerido';
          }
          return null;
        },
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
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.arrow_drop_down, color: Colors.purple),
          border: const OutlineInputBorder(),
        ),
        items: items.map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString()),
        )).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? '$label es requerido' : null,
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required String displayText,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: onTap,
        child: AbsorbPointer(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: label,
              prefixIcon: const Icon(Icons.calendar_today, color: Colors.purple),
              hintText: displayText,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentField({required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        maxLines: 3,
        decoration: const InputDecoration(
          labelText: 'Comentario',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildPhotoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Foto del animal', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Colors.blue, size: 40),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}