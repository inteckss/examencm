import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/category.dart';
import '../models/provider.dart';

class ApiService {
  static const String _baseUrl = "143.198.118.203:8100";
  static const String _user = "test";
  static const String _pass = "test2023";

  // Headers para autenticación básica
  Map<String, String> get _headers {
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}';
    return {
      'Content-Type': 'application/json',
      'Authorization': basicAuth,
    };
  }

  // Productos
  Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(
        Uri.http(_baseUrl, '/ejemplos/product_list_rest/'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting products: $e');
      // Retornar datos de demostración cuando la API no esté disponible
      return _getDemoProducts();
    }
  }

  // Datos de demostración para productos
  List<Product> _getDemoProducts() {
    return [
      // Consolas
      Product(
        id: 1,
        name: 'PlayStation 5 Console',
        price: 499.99,
        imageUrl: 'https://i.imgur.com/yK8fPS5.jpg',
      ),
      Product(
        id: 2,
        name: 'Xbox Series X',
        price: 499.99,
        imageUrl: 'https://i.imgur.com/bZqDXK2.jpg',
      ),
      Product(
        id: 3,
        name: 'Nintendo Switch OLED',
        price: 349.99,
        imageUrl: 'https://i.imgur.com/wK9fDL3.jpg',
      ),
      Product(
        id: 4,
        name: 'PlayStation 4 Pro',
        price: 299.99,
        imageUrl: 'https://i.imgur.com/pL9qE4R.jpg',
      ),
      Product(
        id: 5,
        name: 'Xbox One X',
        price: 249.99,
        imageUrl: 'https://i.imgur.com/vN8tG5S.jpg',
      ),
      Product(
        id: 6,
        name: 'Nintendo Switch Lite',
        price: 199.99,
        imageUrl: 'https://i.imgur.com/bM7dF2Q.jpg',
      ),
      // Joysticks/Controladores
      Product(
        id: 7,
        name: 'DualSense Controller (White)',
        price: 69.99,
        imageUrl: 'https://i.imgur.com/xH5eM2P.jpg',
      ),
      Product(
        id: 8,
        name: 'DualSense Controller (Black)',
        price: 69.99,
        imageUrl: 'https://i.imgur.com/cF7sW9U.jpg',
      ),
      Product(
        id: 9,
        name: 'Xbox Wireless Controller (Carbon Black)',
        price: 59.99,
        imageUrl: 'https://i.imgur.com/nQ8vR4T.jpg',
      ),
      Product(
        id: 10,
        name: 'Xbox Wireless Controller (Shock Blue)',
        price: 59.99,
        imageUrl: 'https://i.imgur.com/mT3hK6L.jpg',
      ),
      Product(
        id: 11,
        name: 'Nintendo Pro Controller',
        price: 69.99,
        imageUrl: 'https://i.imgur.com/jM6qX1E.jpg',
      ),
      Product(
        id: 12,
        name: 'Nintendo Joy-Con (Neon Red/Blue)',
        price: 79.99,
        imageUrl: 'https://i.imgur.com/kR5dP8N.jpg',
      ),
      Product(
        id: 13,
        name: 'DualShock 4 Controller (Black)',
        price: 49.99,
        imageUrl: 'https://i.imgur.com/hP2kL8V.jpg',
      ),
      Product(
        id: 14,
        name: 'DualShock 4 Controller (Blue)',
        price: 49.99,
        imageUrl: 'https://i.imgur.com/vW9fT7M.jpg',
      ),
      Product(
        id: 15,
        name: 'Xbox One Controller (White)',
        price: 44.99,
        imageUrl: 'https://i.imgur.com/qP5xE8K.jpg',
      ),
      // Accesorios
      Product(
        id: 16,
        name: 'Gaming Headset',
        price: 79.99,
        imageUrl: 'https://i.imgur.com/sL4dF9P.jpg',
      ),
      Product(
        id: 17,
        name: 'Gaming Keyboard RGB',
        price: 129.99,
        imageUrl: 'https://i.imgur.com/nX8vB3Q.jpg',
      ),
    ];
  }

  Future<bool> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.http(_baseUrl, '/ejemplos/product_add_rest/'),
        headers: _headers,
        body: json.encode(product.toJsonForAdd()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error adding product: $e');
      return false;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.http(_baseUrl, '/ejemplos/product_edit_rest/'),
        headers: _headers,
        body: json.encode(product.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(int productId) async {
    try {
      final response = await http.post(
        Uri.http(_baseUrl, '/ejemplos/product_del_rest/'),
        headers: _headers,
        body: json.encode({'product_id': productId}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }

  // Categorías
  Future<List<Category>> getCategories() async {
    try {
      final response = await http.get(
        Uri.http(_baseUrl, '/ejemplos/category_list_rest/'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting categories: $e');
      // Retornar datos de demostración cuando la API no esté disponible
      return _getDemoCategories();
    }
  }

  // Datos de demostración para categorías
  List<Category> _getDemoCategories() {
    return [
      Category(
        id: 1,
        name: 'Consolas',
      ),
      Category(
        id: 2,
        name: 'Controladores',
      ),
      Category(
        id: 3,
        name: 'Accesorios Gaming',
      ),
      Category(
        id: 4,
        name: 'Juegos',
      ),
      Category(
        id: 5,
        name: 'Audio Gaming',
      ),
      Category(
        id: 6,
        name: 'Periféricos PC',
      ),
    ];
  }

  Future<bool> addCategory(Category category) async {
    try {
      final response = await http.post(
        Uri.http(_baseUrl, '/ejemplos/category_add_rest/'),
        headers: _headers,
        body: json.encode(category.toJsonForAdd()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error adding category: $e');
      return false;
    }
  }

  Future<bool> updateCategory(Category category) async {
    try {
      final response = await http.post(
        Uri.http(_baseUrl, '/ejemplos/category_edit_rest/'),
        headers: _headers,
        body: json.encode(category.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating category: $e');
      return false;
    }
  }

  Future<bool> deleteCategory(int categoryId) async {
    try {
      final response = await http.post(
        Uri.http(_baseUrl, '/ejemplos/category_del_rest/'),
        headers: _headers,
        body: json.encode({'category_id': categoryId}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting category: $e');
      return false;
    }
  }

  // Proveedores
  Future<List<Provider>> getProviders() async {
    try {
      final response = await http.get(
        Uri.http(_baseUrl, '/ejemplos/provider_list_rest/'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Provider.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load providers: ${response.statusCode}');
      }
    } catch (e) {
      print('Error getting providers: $e');
      // Retornar datos de demostración cuando la API no esté disponible
      return _getDemoProviders();
    }
  }

  // Datos de demostración para proveedores
  List<Provider> _getDemoProviders() {
    return [
      Provider(
        id: 1,
        name: 'Sony Interactive',
        lastName: 'Entertainment',
        email: 'contact@sony.com',
      ),
      Provider(
        id: 2,
        name: 'Microsoft',
        lastName: 'Gaming',
        email: 'xbox@microsoft.com',
      ),
      Provider(
        id: 3,
        name: 'Nintendo of',
        lastName: 'America',
        email: 'support@nintendo.com',
      ),
      Provider(
        id: 4,
        name: 'Electronic',
        lastName: 'Arts',
        email: 'help@ea.com',
      ),
      Provider(
        id: 5,
        name: 'Activision',
        lastName: 'Blizzard',
        email: 'support@activision.com',
      ),
    ];
  }

  Future<bool> addProvider(Provider provider) async {
    try {
      final response = await http.post(
        Uri.http(_baseUrl, '/ejemplos/provider_add_rest/'),
        headers: _headers,
        body: json.encode(provider.toJsonForAdd()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error adding provider: $e');
      return false;
    }
  }

  Future<bool> updateProvider(Provider provider) async {
    try {
      final response = await http.post(
        Uri.http(_baseUrl, '/ejemplos/provider_edit_rest/'),
        headers: _headers,
        body: json.encode(provider.toJson()),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error updating provider: $e');
      return false;
    }
  }

  Future<bool> deleteProvider(int providerId) async {
    try {
      final response = await http.post(
        Uri.http(_baseUrl, '/ejemplos/provider_del_rest/'),
        headers: _headers,
        body: json.encode({'provider_id': providerId}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error deleting provider: $e');
      return false;
    }
  }
}