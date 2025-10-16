class ApiConstants {
  static const String baseUrl = "143.198.118.203:8100";
  static const String user = "test";
  static const String pass = "test2023";
  
  // Productos
  static const String productsList = "/ejemplos/product_list_rest/";
  static const String productAdd = "/ejemplos/product_add_rest/";
  static const String productEdit = "/ejemplos/product_edit_rest/";
  static const String productDelete = "/ejemplos/product_del_rest/";
  
  // Categorías
  static const String categoriesList = "/ejemplos/category_list_rest/";
  static const String categoryAdd = "/ejemplos/category_add_rest/";
  static const String categoryEdit = "/ejemplos/category_edit_rest/";
  static const String categoryDelete = "/ejemplos/category_del_rest/";
  
  // Proveedores
  static const String providersList = "/ejemplos/provider_list_rest/";
  static const String providerAdd = "/ejemplos/provider_add_rest/";
  static const String providerEdit = "/ejemplos/provider_edit_rest/";
  static const String providerDelete = "/ejemplos/provider_del_rest/";
}

class AppStrings {
  // General
  static const String appTitle = "Gaming Console Manager";
  static const String loading = "Cargando...";
  static const String error = "Error";
  static const String retry = "Reintentar";
  static const String cancel = "Cancelar";
  static const String save = "Guardar";
  static const String edit = "Editar";
  static const String delete = "Eliminar";
  static const String add = "Agregar";
  static const String update = "Actualizar";
  
  // Auth
  static const String login = "Iniciar Sesión";
  static const String register = "Registrarse";
  static const String logout = "Cerrar Sesión";
  static const String email = "Email";
  static const String password = "Contraseña";
  static const String confirmPassword = "Confirmar Contraseña";
  static const String forgotPassword = "¿Olvidaste tu contraseña?";
  
  // Navigation
  static const String consoles = "Consolas";
  static const String products = "Productos";
  static const String categories = "Categorías";
  static const String providers = "Proveedores";
  
  // Messages
  static const String successAdd = "Agregado exitosamente";
  static const String successUpdate = "Actualizado exitosamente";
  static const String successDelete = "Eliminado exitosamente";
  static const String errorAdd = "Error al agregar";
  static const String errorUpdate = "Error al actualizar";
  static const String errorDelete = "Error al eliminar";
  static const String errorLoad = "Error al cargar datos";
  
  // Validation
  static const String fieldRequired = "Este campo es requerido";
  static const String invalidEmail = "Email no válido";
  static const String passwordTooShort = "Contraseña muy corta";
  static const String passwordsDontMatch = "Las contraseñas no coinciden";
  static const String invalidPrice = "Precio no válido";
}

class AppValidators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return AppStrings.invalidEmail;
    }
    return null;
  }
  
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired;
    }
    return null;
  }
  
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.fieldRequired;
    }
    if (value.length < 6) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }
  
  static String? price(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.fieldRequired;
    }
    final price = double.tryParse(value);
    if (price == null || price <= 0) {
      return AppStrings.invalidPrice;
    }
    return null;
  }
}