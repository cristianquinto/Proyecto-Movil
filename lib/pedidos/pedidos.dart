import 'package:flutter/material.dart';

/// MÓDULO BASE DE PEDIDOS
/// Estilo corporativo azul y blanco
class PedidoModule extends StatefulWidget {
  const PedidoModule({super.key});

  @override
  State<PedidoModule> createState() => _PedidoModuleState();
}

class _PedidoModuleState extends State<PedidoModule> {
  List<Map<String, dynamic>> pedidos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Módulo de Pedidos"),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: _registrarPedido,
      ),
      body: Column(
        children: [
          _searchBox(),
          Expanded(child: _listPedidos()),
        ],
      ),
    );
  }

  // BUSCAR PEDIDO
  Widget _searchBox() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Buscar pedido...",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  // LISTAR PEDIDOS
  Widget _listPedidos() {
    return ListView.builder(
      itemCount: pedidos.length,
      itemBuilder: (_, i) {
        final p = pedidos[i];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ListTile(
            title: Text("Pedido #${p['id']}", style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Estado: ${p['estado']}") ,
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: () => _verDetallePedido(p),
          ),
        );
      },
    );
  }///aaaaa

  // REGISTRAR PEDIDO
  void _registrarPedido() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RegistrarPedidoPage()),
    ).then((value) {
      if (value != null) {
        setState(() => pedidos.add(value));
      }
    });
  }

  // VER DETALLE PEDIDO
  void _verDetallePedido(Map<String, dynamic> pedido) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetallePedidoPage(pedido: pedido)),
    );
  }
}

// --------------------------------------------
// REGISTRAR PEDIDO
// --------------------------------------------
class RegistrarPedidoPage extends StatefulWidget {
  const RegistrarPedidoPage({super.key});

  @override
  State<RegistrarPedidoPage> createState() => _RegistrarPedidoPageState();
}

class _RegistrarPedidoPageState extends State<RegistrarPedidoPage> {
  final TextEditingController clienteCtrl = TextEditingController();
  List<Map<String, dynamic>> productos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrar Pedido"), backgroundColor: Colors.blue),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.check, color: Colors.white),
        onPressed: _guardarPedido,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: clienteCtrl,
              decoration: InputDecoration(
                labelText: "Cliente",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Productos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                TextButton.icon(
                  onPressed: _agregarProducto,
                  icon: const Icon(Icons.add, color: Colors.blue),
                  label: const Text("Agregar", style: TextStyle(color: Colors.blue)),
                )
              ],
            ),
            Expanded(child: _listProductos()),
          ],
        ),
      ),
    );
  }

  // LISTA DE PRODUCTOS
  Widget _listProductos() {
    return ListView.builder(
      itemCount: productos.length,
      itemBuilder: (_, i) {
        final p = productos[i];
        return Card(
          child: ListTile(
            title: Text(p['nombre']),
            subtitle: Text("Cantidad: ${p['cantidad']}"),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () => setState(() => productos.removeAt(i)),
            ),
          ),
        );
      },
    );
  }

  // AGREGAR PRODUCTO
  void _agregarProducto() {
    setState(() {
      productos.add({"nombre": "Producto X", "cantidad": 1});
    });
  }

  // GUARDAR PEDIDO
  void _guardarPedido() {
    Navigator.pop(context, {
      "id": DateTime.now().millisecondsSinceEpoch,
      "cliente": clienteCtrl.text,
      "estado": "Pendiente",
      "productos": productos,
    });
  }
}

// --------------------------------------------
// DETALLE PEDIDO
// --------------------------------------------
class DetallePedidoPage extends StatelessWidget {
  final Map<String, dynamic> pedido;

  const DetallePedidoPage({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pedido #${pedido['id']}"), backgroundColor: Colors.blue),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cliente: ${pedido['cliente']}", style: const TextStyle(fontSize: 18)),
            Text("Estado: ${pedido['estado']}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text("Productos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView(
                children: pedido['productos'].map<Widget>((p) {
                  return Card(
                    child: ListTile(
                      title: Text(p['nombre']),
                      subtitle: Text("Cantidad: ${p['cantidad']}"),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text("Ver PDF"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),

                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.cancel, color: Colors.white),
                  label: const Text("Cancelar"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}