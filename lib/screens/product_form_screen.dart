import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/data_provider.dart';
import '../widgets/network_image_widget.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  String _selectedState = 'Activo';
  bool _isLoading = false;

  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _nameController.text = widget.product!.name;
      _priceController.text = widget.product!.price.toString();
      _imageController.text = widget.product!.imageUrl;
      _selectedState = widget.product!.state;
    } else {
      _imageController.text = 'https://emprendepyme.net/wp-content/uploads/2023/03/cualidades-producto-1200x900.jpg';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Producto' : 'Nuevo Producto'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Preview de la imagen
              NetworkImageWidget(
                imageUrl: _imageController.text,
                productName: _nameController.text.isNotEmpty ? _nameController.text : 'Nuevo Producto',
                height: 200,
                borderRadius: 12,
              ),
              const SizedBox(height: 20),

              // Campo Nombre
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre del Producto',
                  prefixIcon: const Icon(Icons.inventory),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el nombre del producto';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo Precio
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Precio',
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa el precio';
                  }
                  final price = double.tryParse(value);
                  if (price == null || price <= 0) {
                    return 'Por favor ingresa un precio válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo URL de la imagen
              TextFormField(
                controller: _imageController,
                decoration: InputDecoration(
                  labelText: 'URL de la Imagen',
                  prefixIcon: const Icon(Icons.image),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {}); // Para actualizar el preview
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingresa la URL de la imagen';
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
                  onPressed: _isLoading ? null : _saveProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
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
            ],
          ),
        ),
      ),
    );
  }

  void _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final dataProvider = context.read<DataProvider>();
    final product = Product(
      id: isEditing ? widget.product!.id : 0,
      name: _nameController.text.trim(),
      price: double.parse(_priceController.text),
      imageUrl: _imageController.text.trim(),
      state: _selectedState,
    );

    bool success;
    if (isEditing) {
      success = await dataProvider.updateProduct(product);
    } else {
      success = await dataProvider.addProduct(product);
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
                  ? 'Producto actualizado exitosamente'
                  : 'Producto agregado exitosamente',
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isEditing
                  ? 'Error al actualizar el producto'
                  : 'Error al agregar el producto',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}