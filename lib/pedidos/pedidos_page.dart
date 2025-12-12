import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pedido_controller.dart';
import 'pedido_detalle_page.dart';
import 'seleccionar_productos_page.dart';
import 'pedido_model.dart';

class PedidosPage extends StatelessWidget {
  const PedidosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PedidoController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Pedidos"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          // abre la pantalla de selección y registra pedido si hay items
          final result = await Navigator.push<List<PedidoItem>?>(
            context,
            MaterialPageRoute(builder: (_) => SeleccionarProductosPage()),
          );
          if (result != null && result.isNotEmpty) {
            Provider.of<PedidoController>(context, listen: false)
                .registrarPedido(result);
          }
        },
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        children: [
          const Text(
            "Pedidos actuales",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // pedidos actuales
          ...controller.pedidosActuales.map((p) => _pedidoCard(context, p)),

          const SizedBox(height: 22),
          const Text(
            "Pedidos anteriores",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          ...controller.pedidosAnteriores.map((p) => _pedidoCard(context, p)),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _pedidoCard(BuildContext context, Pedido pedido) {
    final formattedDate =
        "${pedido.fecha.day} de ${_mesNombre(pedido.fecha.month)} de ${pedido.fecha.year}";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6),
        ],
      ),
      child: Row(
        children: [
          // info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(formattedDate,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(
                  "Pedido ${pedido.id}",
                  style: const TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),

          // botones
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade100,
              elevation: 0,
              side: BorderSide(color: Colors.grey.shade200),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => PedidoDetallePage(pedido: pedido)),
              );
            },
            child: const Text("Ver Detalles", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  static String _mesNombre(int mes) {
    const meses = [
      '',
      'enero',
      'febrero',
      'marzo',
      'abril',
      'mayo',
      'junio',
      'julio',
      'agosto',
      'septiembre',
      'octubre',
      'noviembre',
      'diciembre'
    ];
    return meses[mes];
  }
}
