# Guía de Instalación y Uso - 

##  Requisitos Previos

### Sistema
- **Flutter SDK**: versión 3.9.2 o superior
- **Dart SDK**: incluido con Flutter
- **Android Studio** o **VS Code** con extensiones de Flutter
- **Git** para clonar el repositorio

### Para Android
- Android SDK (API level 21 o superior)
- Emulador Android o dispositivo físico

### Para iOS (opcional)
- macOS con Xcode instalado
- iOS Simulator o dispositivo físico

##  Instalación Paso a Paso

### 1. Verificar Instalación de Flutter
```bash
flutter doctor
```
Asegúrate de que no haya problemas críticos.

### 2. Clonar el Proyecto
```bash
git clone <repository-url>
cd examen
```

### 3. Instalar Dependencias
```bash
flutter pub get
```

### 4. Configurar Firebase

#### Crear Proyecto Firebase
1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Crea un nuevo proyecto llamado "gaming-console-manager"
3. Activa **Authentication** → **Sign-in method** → **Email/Password**

#### Configurar Android
1. En Firebase Console: **Project Settings** → **Add app** → **Android**
2. Package name: `com.example.examen`
3. Descarga `google-services.json`
4. Colócalo en `android/app/google-services.json`

#### Configurar iOS (opcional)
1. En Firebase Console: **Add app** → **iOS**
2. Bundle ID: `com.example.examen`
3. Descarga `GoogleService-Info.plist`
4. Colócalo en `ios/Runner/GoogleService-Info.plist`

### 5. Ejecutar la Aplicación
```bash
# Para depuración
flutter run

# Para release
flutter run --release
```

##  Uso de la Aplicación

### Primera Vez

#### 1. Registro de Usuario
- Abre la aplicación
- Toca "¿No tienes cuenta? Regístrate"
- Ingresa email y contraseña (mínimo 6 caracteres)
- Toca "Registrarse"

#### 2. Inicio de Sesión
- Usa las credenciales que acabas de crear
- O crea una cuenta de prueba:
  - Email: `test@example.com`
  - Contraseña: `123456`

### Navegación Principal

#### 🎮 Consolas
- **Ver catálogo**: Lista de consolas disponibles
- **Ver detalles**: Toca cualquier consola para ver información completa
- **Ver joysticks**: En los detalles, encuentra los controles disponibles

####  Productos
- **Listar**: Todos los productos de la API
- **Agregar**: Botón flotante "+" para nuevo producto
- **Editar**: Menú de tres puntos → "Editar"
- **Eliminar**: Menú de tres puntos → "Eliminar" (con confirmación)

####  Categorías
- **Gestión completa**: Similar a productos
- **Estados**: Activa/Inactiva

####  Proveedores
- **Información completa**: Nombre, apellido, email
- **Estados**: Activo/Inactivo
- **CRUD completo**: Crear, leer, actualizar, eliminar

### Funcionalidades Específicas

#### Formularios
- **Validación automática**: Los campos se validan al escribir
- **Mensajes de error**: Aparecen debajo de cada campo
- **Estados de carga**: Botón se deshabilita durante el guardado

#### Manejo de Errores
- **Sin internet**: Mensaje informativo con botón "Reintentar"
- **Errores de API**: Notificaciones con detalles del error
- **Estados vacíos**: Mensajes amigables cuando no hay datos

#### Actualización de Datos
- **Pull to refresh**: Desliza hacia abajo en las listas
- **Actualización automática**: Después de crear/editar/eliminar
- **Estados de carga**: Indicadores visuales durante las operaciones

## 🔧 Resolución de Problemas

### Errores Comunes

#### Error de Firebase
```
Error: No Firebase App '[DEFAULT]' has been created
```
**Solución**: Verifica que `google-services.json` esté en la ubicación correcta.

#### Error de API
```
Error al cargar productos: SocketException
```
**Solución**: 
1. Verifica conexión a internet
2. La API puede estar temporalmente inactiva
3. Usa el botón "Reintentar"

#### Error de Compilación
```
Error: Could not find a command named "run"
```
**Solución**: 
```bash
flutter clean
flutter pub get
flutter run
```

#### Problemas de Rendimiento
- **Imágenes lentas**: Normal en primera carga, se cachean automáticamente
- **Listas lentas**: Los datos se cargan de forma lazy
- **App lenta**: Ejecuta en modo release: `flutter run --release`

### Depuración

#### Logs
```bash
# Ver logs en tiempo real
flutter logs

# Ver logs de la app
adb logcat | grep flutter
```

#### Debugging
```bash
# Modo debug con hot reload
flutter run --debug

# Inspeccionar widgets
# En la app, presiona F12 (desktop) o usa Flutter Inspector
```

## 📱 Características por Plataforma

### Android
- **Versión mínima**: Android 5.0 (API 21)
- **Permisos**: Internet (automático)
- **Tamaño APK**: ~15-20 MB
- **Funcionalidades**: Todas disponibles

### iOS (si se implementa)
- **Versión mínima**: iOS 11.0
- **Permisos**: Configurados automáticamente
- **Tamaño IPA**: ~20-25 MB
- **Funcionalidades**: Todas disponibles

### Web (experimental)
```bash
flutter run -d chrome
```
- **Funcionalidades limitadas**: Algunas características de Firebase pueden no funcionar
- **Rendimiento**: Menor que nativo

##  Consejos de Uso

### Para Mejores Resultados
1. **Conexión estable**: Usa WiFi para mejor experiencia
2. **Registro de datos**: Usa información real para probar completamente
3. **Navegación**: Explora todas las secciones para ver funcionalidades
4. **Estados**: Prueba cambiar estados de activo/inactivo
5. **Formularios**: Prueba validaciones ingresando datos incorrectos

### Datos de Prueba

#### Productos
- **Nombre**: "PlayStation 5 Console"
- **Precio**: 499.99
- **Imagen**: Usar URL por defecto o cualquier URL de imagen válida

#### Categorías
- **Nombre**: "Consolas de Nueva Generación"

#### Proveedores
- **Nombre**: "Sony"
- **Apellido**: "Interactive"
- **Email**: "contact@sony.com"

## 📞 Soporte

### Problemas Técnicos
1. **Revisar documentación**: `README.md` y `TECHNICAL_DOCS.md`
2. **Verificar logs**: `flutter logs`
3. **Limpiar proyecto**: `flutter clean && flutter pub get`
4. **Restart**: Cerrar app completamente y reabrir

### Limitaciones Conocidas
- **API externa**: Dependiente de servidor externo (143.198.118.203:8100)
- **Imágenes**: URLs deben ser válidas y accesibles
- **Firebase**: Requiere configuración manual
- **Estados**: Algunos cambios de estado pueden no persistir en la API

### Mejoras Sugeridas
- Implementar cache offline
- Agregar búsqueda y filtros
- Mejorar manejo de imágenes
- Agregar más validaciones
- Implementar sistema de roles
