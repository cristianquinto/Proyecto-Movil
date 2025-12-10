import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../clientes/client_model.dart';
import '../clientes/client_controller.dart';
import 'client_form_page.dart';

class ClientDetailPage extends StatelessWidget {
  final ClientModel client;
  const ClientDetailPage({required this.client});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ClientController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Detalles del Cliente")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Text(
                client.name.isNotEmpty ? client.name[0] : "",
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),

            SizedBox(height: 10),

            Text(
              "${client.name} ${client.lastName}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(client.email),
            SizedBox(height: 20),

            Chip(label: Text(client.status)),
            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Información del Cliente",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _info("Teléfono", client.phone),
                _info("Ciudad", client.city),
                _info("Dirección", client.address),
                if (client.company != null)
                  _info("Empresa", client.company!),
              ],
            ),

            SizedBox(height: 30),

            // Botón Editar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 45),
              ),
              child: Text(
                "Editar Cliente",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ClientFormPage(editClient: client),
                ),
              ),
            ),

            SizedBox(height: 10),

            // Botón Eliminar
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 45),
              ),
              child: Text(
                "Eliminar Cliente",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => _confirmDelete(context, controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _info(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey)),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  // CUADRO DE CONFIRMACIÓN  
  void _confirmDelete(BuildContext context, ClientController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar eliminación"),
        content: Text("¿Seguro que quieres eliminar este cliente?"),
        actions: [
          TextButton(
            child: Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text("Eliminar", style: TextStyle(color: Colors.white)),
            onPressed: () {
              controller.removeClient(client.id);

              Navigator.pop(context); // Cierra el diálogo
              Navigator.pop(context); // Vuelve a la lista
            },
          ),
        ],
      ),
    );
  }
}
