import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/pedido_controller.dart';
import 'screens/pedidos/pedidos_page.dart';

// Importa tus módulos existentes
import 'controllers/client_controller.dart';
import 'clientes/client_list_page.dart';
import 'controllers/auth_controller.dart';

import 'screens/recuperar.dart';
import 'screens/sesion.dart';

// =========================================================
// MÓDULOS DEL CATÁLOGO DE REPUESTOS (Nuevas Importaciones)
// =========================================================
import 'screens/home_screen.dart'; // Tu nueva pantalla de inicio de repuestos
import 'screens/catalog_screen.dart';
import 'screens/cart_screen.dart';
// Note: product.dart y product_detail_screen.dart no necesitan importarse aquí
// ya que solo se llaman desde otras screens.

// Define un controlador de estado simple para el carrito (opcional, pero buena práctica)
// Si no quieres crear un archivo aparte, puedes usar este placeholder:
class CartController with ChangeNotifier {
  // Aquí iría la lógica de añadir/eliminar productos del carrito
  int get itemCount => 0; // Ejemplo
}

// Color corporativo de repuestos (Azul Claro)
const Color primaryColorParts = Color.fromRGBO(18, 128, 227, 1);

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Proveedores existentes
        ChangeNotifierProvider(create: (_) => ClientController()),
        ChangeNotifierProvider(create: (_) => PedidoController()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => CartController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(18, 128, 227, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
      ),
      home: auth.isLoggedIn ? const MainScaffold() : SesionPage(),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int currentIndex = 0;

  final pages = [
    HomeScreen(),
    const CatalogScreen(),
    const CartScreen(),
    PedidosPage(),
    ClientListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: Text(
          _getAppTitle(currentIndex),
          style: TextStyle(
            color: currentIndex == 0 ? Colors.black : Color.fromRGBO(18, 128, 227, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthController>().logout();
            },
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: const Color.fromRGBO(18, 128, 227, 1),
        unselectedItemColor: Colors.blueGrey,
        onTap: (i) => setState(() => currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Productos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Pedidos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Clientes'),
        ],
      ),
    );
  }

  String _getAppTitle(int index) {
    switch (index) {
      case 0:
        return 'AutoParts Pro - Repuestos';
      case 1:
        return 'Catálogo de Repuestos';
      case 2:
        return 'Mi Carrito';
      case 3:
        return 'Historial de Pedidos';
      case 4:
        return 'Gestión de Clientes';
      default:
        return 'Jtools app';
    }
  }
}
