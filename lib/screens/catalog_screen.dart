// lib/screens/catalog_screen.dart
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

const Color primaryColor = Color(0xFF81D4FA); // Azul Claro Corporativo

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color.fromRGBO(18, 128, 227, 1)
),
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar por Nombre, Marca o No. Parte...',
                prefixIcon: const Icon(Icons.search, color: Color.fromRGBO(18, 128, 227, 1)
),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Color.fromRGBO(18, 128, 227, 1)
),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Color.fromRGBO(18, 129, 227, 0.425)),
                ),
                contentPadding: const EdgeInsets.all(10.0),
              ),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dos tarjetas por fila
          childAspectRatio: 0.75, // Ajustado para una proporción más equilibrada
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          final product = dummyProducts[index];
          return ProductGridItem(product: product);
        },
      ),
    );
  }
}

class ProductGridItem extends StatelessWidget {
  final Product product;
  const ProductGridItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen simulada
            Container(
              height: 160,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                Image.asset 'assets/images/BIELETACLIO.jpg'
                // Aquí iría Image.network(product.imageUrl) si tuvieses una imagen
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.car_repair, size: 50, color: primaryColor),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título del producto con control de desbordamiento
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2, // Limita el texto a 2 líneas
                    overflow: TextOverflow.ellipsis, // Evita que el texto se desborde
                  ),
                  const SizedBox(height: 4),
                  // No. de parte del producto
                  Text(
                    'No. Parte: ${product.partNumber}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  // Precio del producto
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color.fromRGBO(18, 128, 227, 1),
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
