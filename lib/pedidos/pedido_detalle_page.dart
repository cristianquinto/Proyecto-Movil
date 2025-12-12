import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// PDF
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

// Controlador y modelo
import 'pedido_controller.dart';
import 'pedido_model.dart';

class PedidoDetallePage extends StatelessWidget {
  final Pedido pedido;

  const PedidoDetallePage({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PedidoController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido ${pedido.id}"),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () => _generarPdf(context),
            tooltip: 'Ver PDF',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fecha: ${pedido.fecha.toString().substring(0, 16)}",
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),

            Text(
              "Estado: ${pedido.estado}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 14),
            const Text(
              "Productos:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // LISTA DE PRODUCTOS
            Expanded(
              child: ListView(
                children: pedido.items.map((it) {
                  return ListTile(
                    title: Text(it.nombre),
                    subtitle:
                        Text('Precio: \$${it.precio.toStringAsFixed(0)}'),
                    trailing: Text('x ${it.cantidad}'),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 8),

            // TOTAL
            Text(
              'Total: \$${pedido.total.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // BOTONES
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      controller.cambiarEstado(pedido, 'Completado');

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pedido marcado como Completado'),
                        ),
                      );
                    },
                    child: const Text('Marcar como completado'),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      controller.cancelarPedido(pedido);
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar pedido'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --------------------------
  // PDF GENERATOR
  // --------------------------
  Future<void> _generarPdf(BuildContext context) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context ctx) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                'Pedido ${pedido.id}',
                style: pw.TextStyle(fontSize: 24),
              ),
            ),

            pw.Text('Fecha: ${pedido.fecha.toString().substring(0, 16)}'),
            pw.SizedBox(height: 12),

            pw.Text('Estado: ${pedido.estado}'),
            pw.Divider(),

            pw.Table.fromTextArray(
              headers: ['Producto', 'Precio', 'Cantidad', 'Subtotal'],
              data: pedido.items.map((it) {
                final subtotal = it.precio * it.cantidad;
                return [
                  it.nombre,
                  '\$${it.precio.toStringAsFixed(0)}',
                  '${it.cantidad}',
                  '\$${subtotal.toStringAsFixed(0)}'
                ];
              }).toList(),
            ),

            pw.Divider(),

            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                'Total: \$${pedido.total.toStringAsFixed(0)}',
                style: pw.TextStyle(
                    fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }
}
