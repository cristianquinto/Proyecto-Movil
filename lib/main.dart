import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Módulo clientes
import 'clientes/client_controller.dart';
import 'clientes/client_list_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientController()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _homeView(),           // Tu pantalla original
      _placeholder("Menú"),
      _placeholder("Carrito"),
      _placeholder("Pedidos"),
      ClientListPage(),      // Vista de clientes funcionando
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          title: const Text("Jtools app"),
        ),

        body: pages[currentIndex],

        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.black54,
          onTap: (i) => setState(() => currentIndex = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menú'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: 'Carrito'),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long), label: 'Pedidos'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Clientes'),
          ],
        ),
      ),
    );
  }

  // =======================================================================
  // === 1. TU PANTALLA ORIGINAL DE INICIO (SIN MODIFICACIONES) ============
  // =======================================================================

  Widget _homeView() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // === CABECERA ===
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      const Text(
                        'Dulce Delicia',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.shopping_cart_outlined,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'Categorías',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 16),

                  // === CARD 1 ===
                  buildCard(
                    imageUrl:
                        'https://www.recetasnestle.com.co/sites/default/files/styles/recipe_detail_desktop_new/public/srh_recipes/8b80d005d2b35d7a583470e3f19c9c1f.jpeg?itok=7TbncD74',
                    title: 'Pasteles',
                    description: 'Celebra con nuestros exquisitos pasteles',
                    price: '12000 ',
                  ),
                  const SizedBox(height: 16),

                  // === CARD 2 ===
                  buildCard(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvjx3vebg4PX1WCOOVOnQ2vG3zDuTs_TU-3Q&s',
                    title: 'Galletas',
                    description: 'Disfruta de nuestras deliciosas galletas',
                    price: '10000',
                  ),
                  const SizedBox(height: 16),

                  // === CARD 3 ===
                  buildCard(
                    imageUrl:
                        'https://images.ctfassets.net/naglem4vigsd/3ghnulN27uzMoUucb6Bhrw/25e6313d2060e0847c1aa677d6243344/easy_flan2_0-en-us?fm=webp&w=3840',
                    title: 'Postres Individuales',
                    description: 'Prueba nuestros postres individuales',
                    price: '7000',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =======================================================================
  // === COMPARTIDO PARA TARJETAS (TAL COMO LO TENÍAS) ======================
  // =======================================================================

  static Widget buildCard({
    required String imageUrl,
    required String title,
    required String description,
    required String price,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
              color: Colors.white12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                  child: const Text(
                    'Ver más',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =======================================================================
  // === PLACEHOLDER PARA OTRAS PESTAÑAS ===================================
  // =======================================================================

  Widget _placeholder(String text) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}
