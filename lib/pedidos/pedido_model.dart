class Pedido {
  final String id;
  final DateTime fecha;
  String estado;
  List<PedidoItem> items;

  Pedido({
    required this.id,
    required this.fecha,
    required this.estado,
    required this.items,
  });

  double get total =>
      items.fold(0.0, (sum, it) => sum + (it.precio * it.cantidad));
}

class PedidoItem {
  final String nombre;
  final double precio;
  int cantidad;

  PedidoItem({
    required this.nombre,
    required this.precio,
    this.cantidad = 1,
  });
}
