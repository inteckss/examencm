import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../providers/data_provider.dart';

class CategoryFormScreen extends StatefulWidget {
  final Category? category;

  const CategoryFormScreen({super.key, this.category});

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  String _selectedState = 'Activa';
  bool _isLoading = false;

  bool get isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _nameController.text = widget.category!.name;
      _selectedState = widget.category!.state;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Categoría' : 'Nueva Categoría'),
        backgroundColor: Colors.purple[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Icono de categoría
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.purple[100],
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(
                  Icons.category,
                  size: 60,
                  color: Colors.purple[600],
                ),
              ),
              const SizedBox(height: 30),

              // Campo Nombre
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de la Categoría',
                  prefixIcon: const Icon(Icons.category),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el nombre de la categoría';
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
                    DropdownMenuItem(value: 'Activa', child: Text('Activa')),
                    DropdownMenuItem(value: 'Inactiva', child: Text('Inactiva')),
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
                  onPressed: _isLoading ? null : _saveCategory,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[600],
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
                            ? 'Puedes cambiar el estado de la categoría para activarla o desactivarla.'
                            : 'Las nuevas categorías se crean en estado activo por defecto.',
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

  void _saveCategory() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final dataProvider = context.read<DataProvider>();
    final category = Category(
      id: isEditing ? widget.category!.id : 0,
      name: _nameController.text.trim(),
      state: _selectedState,
    );

    bool success;
    if (isEditing) {
      success = await dataProvider.updateCategory(category);
    } else {
      success = await dataProvider.addCategory(category);
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
                  ? 'Categoría actualizada exitosamente'
                  : 'Categoría agregada exitosamente',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing
                  ? 'Error al actualizar la categoría'
                  : 'Error al agregar la categoría',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}