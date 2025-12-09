import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:  Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          title: Text("Jtools app"),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:  EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // === CABECERA ===
                    Stack(
                      alignment: Alignment.center,
                      children: [
                          Text(
                            'Dulce Delicia',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              ),
                              ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.shopping_cart_outlined, color: Colors.black),
                          ),
                              ]),
                      SizedBox(height: 24),

                      Text(
                        'Categorías',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      SizedBox(height: 16),

                      // === CARD 1 ===
                      buildCard(
                        imageUrl:
                            'https://www.recetasnestle.com.co/sites/default/files/styles/recipe_detail_desktop_new/public/srh_recipes/8b80d005d2b35d7a583470e3f19c9c1f.jpeg?itok=7TbncD74',
                        title: 'Pasteles',
                        description:
                            'Celebra con nuestros exquisitos pasteles',
                            price: '12000 '
                      ),
                      SizedBox(height: 16),

                      // === CARD 2 ===
                      buildCard(
                        imageUrl:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvjx3vebg4PX1WCOOVOnQ2vG3zDuTs_TU-3Q&s',
                        title: 'Galletas',
                        description:
                            'Disfruta de nuestras deliciosas galletas',
                        price: '10000'
                      ),
                      SizedBox(height: 16),

                      // === CARD 3 ===
                      buildCard(
                        imageUrl:
                            'https://images.ctfassets.net/naglem4vigsd/3ghnulN27uzMoUucb6Bhrw/25e6313d2060e0847c1aa677d6243344/easy_flan2_0-en-us?fm=webp&w=3840',
                        title: 'Postres Individuales',
                        description:
                            'Prueba nuestros postres individuales',
                        price: '7000'
                      ),
                    ]),
                ),
              ),
            ),

            // === NAVEGACIÓN INFERIOR ===
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
                ]),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: 0,
                selectedItemColor: Colors.pink,
                unselectedItemColor: Colors.black54,
                items:  [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Inicio'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: 'Menú'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart_outlined),
                      label: 'Carrito'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.receipt_long), label: 'Pedidos'),
                ]),
            ),
          ]),
      ),
    );
  }

  // === TARJETA DE CATEGORÍA ===
  static Widget buildCard({
    required String imageUrl,
    required String title,
    required String description,
    required String price,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow:  [
          BoxShadow(
              color: Colors.white12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Imagen superior
          ClipRRect(
            borderRadius:  BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Texto + botón
          Padding(
            padding:  EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      title,
                      style:  TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold), 
                        ),
                        SizedBox(height: 5),
                        Text(
                          description,
                          style:  TextStyle(color: Colors.black54),
                          ),
                  ]),
                 SizedBox(height: 10),
                Align(
                   child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child:  Text(
                      'Ver más',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ]),
          ),
        ]),
    );
  }
}
