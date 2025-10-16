Una aplicación Flutter completa para gestionar consolas de videojuegos, sus joysticks, y realizar operaciones CRUD con productos, categorías y proveedores.

 Características

 Consolas y Joysticks
- **Catálogo de Consolas**: PlayStation 5, Xbox Series X, Nintendo Switch, PlayStation 4, Xbox One
**Detalles de Joysticks**: Para cada consola se muestran sus controles disponibles
**Información Completa**: Especificaciones, conectividad, imágenes

 Autenticación
- **Login con Firebase**: Email y contraseña
- **Registro de usuarios**: Crear nuevas cuentas
- **Gestión de sesión**: Mantener usuario logueado
- **Recuperación de contraseña**: Reset por email

 Gestión de Datos (API REST)
- **Productos**: CRUD completo con nombre, precio, imagen y estado
- **Categorías**: CRUD con nombre y estado
- **Proveedores**: CRUD con nombre, apellido, email y estado

Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo
- **Firebase Auth**: Autenticación de usuarios
- **Provider**: Gestión de estado
- **HTTP**: Consumo de API REST
- **Material Design**: Interfaz de usuario

 API Endpoints

La aplicación consume una API REST con las siguientes credenciales:
- **URL Base**: 143.198.118.203:8100
- **Usuario**: test
- **Contraseña**: test2023

### Productos
`GET /ejemplos/product_list_rest/` - Listar productos
`POST /ejemplos/product_add_rest/` - Agregar producto
`POST /ejemplos/product_edit_rest/` - Editar producto
`POST /ejemplos/product_del_rest/` - Eliminar producto

### Categorías
`GET /ejemplos/category_list_rest/` - Listar categorías
`POST /ejemplos/category_add_rest/` - Agregar categoría
`POST /ejemplos/category_edit_rest/` - Editar categoría
`POST /ejemplos/category_del_rest/` - Eliminar categoría

### Proveedores
`GET /ejemplos/provider_list_rest/` - Listar proveedores
`POST /ejemplos/provider_add_rest/` - Agregar proveedor
`POST /ejemplos/provider_edit_rest/` - Editar proveedor
`POST /ejemplos/provider_del_rest/` - Eliminar proveedor

## Estructura del Proyecto

```
lib/
├── models/           # Modelos de datos
├── services/         # Servicios (API, Auth, Consolas)
├── providers/        # Gestión de estado
├── screens/          # Pantallas de la app
├── widgets/          # Widgets reutilizables
└── main.dart         # Punto de entrada
```
## Funcionalidades por Pantalla

Login
- Formulario de autenticación
- Validación de campos
- Cambio entre login y registro
- Manejo de errores

Home
- Navegación por tabs
- Carga automática de datos
- Menú de usuario
- Cerrar sesión

Consolas
- Lista de consolas disponibles
- Detalles de cada consola
- Información de joysticks
- Navegación fluida

Productos
- Lista con imágenes
- Agregar/Editar/Eliminar
- Estados (Activo/Inactivo)
- Validación de formularios

Categorías
- CRUD completo
- Estados configurables
- Interfaz simple y clara

Proveedores
- Gestión de contactos
- Información completa
- Estados activo/inactivo

## Diseño y UX

- **Material Design**: Interfaz moderna y consistente
- **Colores temáticos**: Diferentes colores por sección
- **Navegación intuitiva**: Bottom navigation y AppBar
- **Feedback visual**: Loading, errores y estados vacíos
- **Responsive**: Adaptable a diferentes tamaños

## Manejo de Errores

- **Conexión a internet**: Mensajes informativos
- **Errores de API**: Reintentos automáticos
- **Validación**: Formularios con validación en tiempo real
- **Estados de carga**: Indicadores visuales

## Autor

Desarrollado como proyecto de examen por Claudio Aguilera C. para la materia de Computación Móvil.
