import 'package:flutter/material.dart';
import 'pedido_model.dart';

class PedidoController extends ChangeNotifier {
  final List<Pedido> _pedidos = [];

  List<Pedido> get pedidos => List.unmodifiable(_pedidos);

  List<Pedido> get pedidosActuales =>
      _pedidos.where((p) => p.estado != "Cancelado").toList();

  List<Pedido> get pedidosAnteriores =>
      _pedidos.where((p) => p.estado == "Cancelado").toList();

  void registrarPedido(List<PedidoItem> items) {
    final pedido = Pedido(
      id: "#${100000 + _pedidos.length + 1}",
      fecha: DateTime.now(),
      estado: "Pendiente",
      items: items,
    );
    _pedidos.insert(0, pedido);
    notifyListeners();
  }

  void editarPedido(Pedido pedido, List<PedidoItem> nuevosItems) {
    pedido.items = nuevosItems;
    notifyListeners();
  }

  void cambiarEstado(Pedido pedido, String nuevoEstado) {
    pedido.estado = nuevoEstado;
    notifyListeners();
  }

  void cancelarPedido(Pedido pedido) {
    pedido.estado = "Cancelado";
    notifyListeners();
  }

  void eliminarPedido(Pedido pedido) {
    _pedidos.remove(pedido);
    notifyListeners();
  }
}
