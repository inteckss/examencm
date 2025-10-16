import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../models/provider.dart';
import '../services/api_service.dart';

class DataProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  // Products
  List<Product> _products = [];
  bool _productsLoading = false;
  String _productsError = '';

  List<Product> get products => _products;
  bool get productsLoading => _productsLoading;
  String get productsError => _productsError;

  // Categories
  List<Category> _categories = [];
  bool _categoriesLoading = false;
  String _categoriesError = '';

  List<Category> get categories => _categories;
  bool get categoriesLoading => _categoriesLoading;
  String get categoriesError => _categoriesError;

  // Providers
  List<Provider> _providers = [];
  bool _providersLoading = false;
  String _providersError = '';

  List<Provider> get providers => _providers;
  bool get providersLoading => _providersLoading;
  String get providersError => _providersError;

  // Products methods
  Future<void> loadProducts() async {
    _productsLoading = true;
    _productsError = '';
    notifyListeners();

    try {
      _products = await _apiService.getProducts();
      _productsLoading = false;
      notifyListeners();
    } catch (e) {
      _productsLoading = false;
      _productsError = 'Error al cargar productos: $e';
      notifyListeners();
    }
  }

  Future<bool> addProduct(Product product) async {
    try {
      final success = await _apiService.addProduct(product);
      if (success) {
        await loadProducts(); // Recargar la lista
      }
      return success;
    } catch (e) {
      _productsError = 'Error al agregar producto: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      final success = await _apiService.updateProduct(product);
      if (success) {
        await loadProducts(); // Recargar la lista
      }
      return success;
    } catch (e) {
      _productsError = 'Error al actualizar producto: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProduct(int productId) async {
    try {
      final success = await _apiService.deleteProduct(productId);
      if (success) {
        await loadProducts(); // Recargar la lista
      }
      return success;
    } catch (e) {
      _productsError = 'Error al eliminar producto: $e';
      notifyListeners();
      return false;
    }
  }

  // Categories methods
  Future<void> loadCategories() async {
    _categoriesLoading = true;
    _categoriesError = '';
    notifyListeners();

    try {
      _categories = await _apiService.getCategories();
      _categoriesLoading = false;
      notifyListeners();
    } catch (e) {
      _categoriesLoading = false;
      _categoriesError = 'Error al cargar categorías: $e';
      notifyListeners();
    }
  }

  Future<bool> addCategory(Category category) async {
    try {
      final success = await _apiService.addCategory(category);
      if (success) {
        await loadCategories(); // Recargar la lista
      }
      return success;
    } catch (e) {
      _categoriesError = 'Error al agregar categoría: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateCategory(Category category) async {
    try {
      final success = await _apiService.updateCategory(category);
      if (success) {
        await loadCategories(); // Recargar la lista
      }
      return success;
    } catch (e) {
      _categoriesError = 'Error al actualizar categoría: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteCategory(int categoryId) async {
    try {
      final success = await _apiService.deleteCategory(categoryId);
      if (success) {
        await loadCategories(); // Recargar la lista
      }
      return success;
    } catch (e) {
      _categoriesError = 'Error al eliminar categoría: $e';
      notifyListeners();
      return false;
    }
  }

  // Providers methods
  Future<void> loadProviders() async {
    _providersLoading = true;
    _providersError = '';
    notifyListeners();

    try {
      _providers = await _apiService.getProviders();
      _providersLoading = false;
      notifyListeners();
    } catch (e) {
      _providersLoading = false;
      _providersError = 'Error al cargar proveedores: $e';
      notifyListeners();
    }
  }

  Future<bool> addProvider(Provider provider) async {
    try {
      final success = await _apiService.addProvider(provider);
      if (success) {
        await loadProviders(); // Recargar la lista
      }
      return success;
    } catch (e) {
      _providersError = 'Error al agregar proveedor: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateProvider(Provider provider) async {
    try {
      final success = await _apiService.updateProvider(provider);
      if (success) {
        await loadProviders(); // Recargar la lista
      }
      return success;
    } catch (e) {
      _providersError = 'Error al actualizar proveedor: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteProvider(int providerId) async {
    try {
      final success = await _apiService.deleteProvider(providerId);
      if (success) {
        await loadProviders(); // Recargar la lista
      }
      return success;
    } catch (e) {
      _providersError = 'Error al eliminar proveedor: $e';
      notifyListeners();
      return false;
    }
  }

  // Clear errors
  void clearProductsError() {
    _productsError = '';
    notifyListeners();
  }

  void clearCategoriesError() {
    _categoriesError = '';
    notifyListeners();
  }

  void clearProvidersError() {
    _providersError = '';
    notifyListeners();
  }
}