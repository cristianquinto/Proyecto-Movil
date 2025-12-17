import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Repuestos'),
        centerTitle: true,
      ),

      // 🔽 LISTA / GRID DE PRODUCTOS
      body: GridView.builder(
        padding: const EdgeInsets.all(12),

        // 👉 CUÁNTOS PRODUCTOS MOSTRAR
        itemCount: dummyProducts.length,

        // 👉 CONFIGURA EL GRID
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,        // 2 productos por fila
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.72,   // Proporción de la tarjeta
        ),

        itemBuilder: (context, index) {
          final product = dummyProducts[index];

          return GestureDetector(
            onTap: () {
              // 👉 IR A DETALLE
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailScreen(product: product),
                ),
              );
            },
            child: _ProductCard(product: product),
          );
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 🖼️ IMAGEN DESDE ASSETS
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
              //aqui es donde va el tamaño de la imagen tambien define el contenedor y la enlaza directamente
              child: Image.asset(
                product.imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(Icons.image_not_supported, size: 40),
                  );
                },
              ),
            ),
          ),

          // 📄 INFO DEL PRODUCTO
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
