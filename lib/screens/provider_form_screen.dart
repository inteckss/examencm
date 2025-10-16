import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/provider.dart' as models;
import '../providers/data_provider.dart';

class ProviderFormScreen extends StatefulWidget {
  final models.Provider? provider;

  const ProviderFormScreen({super.key, this.provider});

  @override
  State<ProviderFormScreen> createState() => _ProviderFormScreenState();
}

class _ProviderFormScreenState extends State<ProviderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedState = 'Activo';
  bool _isLoading = false;

  bool get isEditing => widget.provider != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _nameController.text = widget.provider!.name;
      _lastNameController.text = widget.provider!.lastName;
      _emailController.text = widget.provider!.email;
      _selectedState = widget.provider!.state;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Proveedor' : 'Nuevo Proveedor'),
        backgroundColor: Colors.orange[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar del proveedor
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Icon(
                    Icons.business,
                    size: 60,
                    color: Colors.orange[600],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Campo Nombre
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Apellido
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el apellido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Por favor ingresa un email válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Dropdown Estado (solo para edición)
              if (isEditing) ...[
                DropdownButtonFormField<String>(
                  value: _selectedState,
                  decoration: InputDecoration(
                    labelText: 'Estado',
                    prefixIcon: const Icon(Icons.toggle_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Activo', child: Text('Activo')),
                    DropdownMenuItem(value: 'Inactivo', child: Text('Inactivo')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedState = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
              ] else
                const SizedBox(height: 20),

              // Botón Guardar
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveProvider,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[600],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          isEditing ? 'Actualizar' : 'Guardar',
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
              ),

              // Información adicional
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[600]),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        isEditing
                            ? 'Puedes cambiar el estado del proveedor para activarlo o desactivarlo.'
                            : 'Los nuevos proveedores se crean en estado activo por defecto.',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProvider() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final dataProvider = context.read<DataProvider>();
    final provider = models.Provider(
      id: isEditing ? widget.provider!.id : 0,
      name: _nameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      state: _selectedState,
    );

    bool success;
    if (isEditing) {
      success = await dataProvider.updateProvider(provider);
    } else {
      success = await dataProvider.addProvider(provider);
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      if (success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing
                  ? 'Proveedor actualizado exitosamente'
                  : 'Proveedor agregado exitosamente',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing
                  ? 'Error al actualizar el proveedor'
                  : 'Error al agregar el proveedor',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}