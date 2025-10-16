# Documentación Técnica - Gaming Console Manager

## Arquitectura de la Aplicación

### Patrón de Arquitectura
La aplicación sigue el patrón **Provider + Repository** con las siguientes capas:

1. **Presentación (UI)**: Screens y Widgets
2. **Lógica de Negocio**: Providers (Estado)
3. **Servicios**: APIs y Firebase
4. **Modelos**: Clases de datos

### Gestión de Estado
- **Provider**: Para el manejo del estado global
- **AuthProvider**: Manejo de autenticación
- **DataProvider**: Manejo de datos de la API

## Estructura Detallada

### Models
```dart
// Console & Joystick
class Console {
  final int id;
  final String name;
  final String manufacturer;
  final int year;
  final String description;
  final String imageUrl;
  final List<Joystick> joysticks;
}

class Joystick {
  final int id;
  final String name;
  final String type;
  final String imageUrl;
  final int consoleId;
  final String connectivity;
  final bool isWireless;
}

// API Models
class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl;
  final String state;
}

class Category {
  final int id;
  final String name;
  final String state;
}

class Provider {
  final int id;
  final String name;
  final String lastName;
  final String email;
  final String state;
}
```

### Services

#### AuthService
```dart
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Stream<User?> get authStateChanges;
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password);
  Future<UserCredential?> registerWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> resetPassword(String email);
}
```

#### ApiService
```dart
class ApiService {
  static const String _baseUrl = "143.198.118.203:8100";
  static const String _user = "test";
  static const String _pass = "test2023";
  
  // HTTP Basic Auth headers
  Map<String, String> get _headers;
  
  // CRUD Operations for Products, Categories, Providers
  Future<List<T>> getItems<T>();
  Future<bool> addItem<T>(T item);
  Future<bool> updateItem<T>(T item);
  Future<bool> deleteItem<T>(int id);
}
```

#### ConsoleService
```dart
class ConsoleService {
  // Static data for consoles and joysticks
  static List<Console> getConsoles();
  static List<Joystick> getJoysticksByConsole(int consoleId);
  static Console? getConsoleById(int id);
  static Joystick? getJoystickById(int id);
}
```

### Providers

#### AuthProvider
```dart
class AuthProvider extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String _errorMessage = '';
  
  // Getters
  bool get isAuthenticated => _user != null;
  
  // Methods
  Future<bool> signIn(String email, String password);
  Future<bool> register(String email, String password);
  Future<void> signOut();
  Future<bool> resetPassword(String email);
}
```

#### DataProvider
```dart
class DataProvider extends ChangeNotifier {
  // Products
  List<Product> _products = [];
  bool _productsLoading = false;
  String _productsError = '';
  
  // Categories
  List<Category> _categories = [];
  bool _categoriesLoading = false;
  String _categoriesError = '';
  
  // Providers
  List<Provider> _providers = [];
  bool _providersLoading = false;
  String _providersError = '';
  
  // CRUD Methods for each entity
  Future<void> loadItems();
  Future<bool> addItem(T item);
  Future<bool> updateItem(T item);
  Future<bool> deleteItem(int id);
}
```

### Screens

#### Principales
- **LoginScreen**: Autenticación de usuarios
- **HomeScreen**: Pantalla principal con navegación por tabs
- **ConsolesScreen**: Listado de consolas
- **ConsoleDetailScreen**: Detalles de consola y joysticks

#### CRUD Screens
- **ProductsScreen** + **ProductFormScreen**
- **CategoriesScreen** + **CategoryFormScreen**
- **ProvidersScreen** + **ProviderFormScreen**

## Flujo de Datos

### Autenticación
```
LoginScreen → AuthProvider → AuthService → Firebase Auth
     ↓
AuthStateChange → AuthProvider → notifyListeners()
     ↓
MyApp (Consumer) → HomeScreen / LoginScreen
```

### Operaciones CRUD
```
FormScreen → DataProvider → ApiService → REST API
     ↓
Response → DataProvider → notifyListeners()
     ↓
ListScreen (Consumer) → UI Update
```

### Datos de Consolas
```
ConsolesScreen → ConsoleService → Static Data
     ↓
ConsoleDetailScreen → Display Console + Joysticks
```

## Configuración

### Firebase
```javascript
// android/app/google-services.json
{
  "project_info": {
    "project_id": "gaming-console-manager"
  },
  "client": [...]
}
```

### API Configuration
```dart
class ApiConstants {
  static const String baseUrl = "143.198.118.203:8100";
  static const String user = "test";
  static const String pass = "test2023";
}
```

## Manejo de Errores

### Niveles de Error
1. **Network Errors**: Timeout, No Internet
2. **API Errors**: 4xx, 5xx HTTP status codes
3. **Firebase Errors**: Auth failures
4. **Validation Errors**: Form validation

### Estrategias
```dart
try {
  final result = await apiService.getProducts();
  _products = result;
  _productsError = '';
} catch (e) {
  _productsError = 'Error al cargar productos: $e';
} finally {
  _productsLoading = false;
  notifyListeners();
}
```

## UI/UX Considerations

### Temas y Colores
- **Primary**: Blue (#2196F3) - Consolas
- **Secondary**: Green (#4CAF50) - Productos
- **Accent**: Purple (#9C27B0) - Categorías
- **Warning**: Orange (#FF9800) - Proveedores

### Estados de UI
- **Loading**: CircularProgressIndicator
- **Empty**: EmptyStateWidget con icono y mensaje
- **Error**: ErrorWidget con botón de retry
- **Success**: SnackBar con mensaje de confirmación

### Navegación
- **Bottom Navigation**: 4 tabs principales
- **Stack Navigation**: Para formularios y detalles
- **Modal Navigation**: Para dialogs de confirmación

## Testing Strategy

### Unit Tests
- Models: JSON serialization/deserialization
- Services: API calls mocking
- Providers: State management logic

### Widget Tests
- Forms: Validation logic
- Lists: Display and interaction
- Navigation: Route transitions

### Integration Tests
- Auth Flow: Login → Home → Logout
- CRUD Flow: List → Add → Edit → Delete
- Console Flow: List → Detail → Back

## Performance Optimizations

### Image Loading
```dart
Image.network(
  url,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) => PlaceholderWidget(),
  loadingBuilder: (context, child, loadingProgress) => LoadingWidget(),
)
```

### List Performance
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
)
```

### State Management
- Lazy loading de datos
- Cache de imágenes
- Dispose de controllers

## Security Considerations

### API Security
- HTTP Basic Authentication
- HTTPS endpoints (recomendado)
- Input validation y sanitization

### Firebase Security
- Firestore Rules (si se implementa)
- Authentication rules
- Secure token management

### Data Validation
- Client-side validation
- Server-side validation
- SQL injection prevention

## Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web (opcional)
```bash
flutter build web --release
```

## Future Enhancements

### Features
- [ ] Offline support con SQLite
- [ ] Push notifications
- [ ] Image upload functionality
- [ ] Search and filters
- [ ] User profiles
- [ ] Admin panel

### Technical
- [ ] GraphQL instead of REST
- [ ] Bloc pattern implementation
- [ ] Automated testing pipeline
- [ ] Performance monitoring
- [ ] Crash reporting

## Dependencies

### Production
```yaml
dependencies:
  flutter: sdk: flutter
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  http: ^1.2.2
  provider: ^6.1.2
  go_router: ^14.6.2
  cupertino_icons: ^1.0.8
```

### Development
```yaml
dev_dependencies:
  flutter_test: sdk: flutter
  flutter_lints: ^5.0.0
```

## Maintenance

### Code Standards
- Dart effective style guide
- Consistent naming conventions
- Documentation comments
- Error handling patterns

### Version Control
- Feature branch workflow
- Semantic versioning
- Changelog maintenance
- Release notes

### Monitoring
- Crash reporting
- Performance metrics
- User analytics
- API usage monitoring