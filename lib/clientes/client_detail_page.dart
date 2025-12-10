import 'package:flutter/material.dart';
import '../clientes/client_model.dart';
import 'client_form_page.dart';

class ClientDetailPage extends StatelessWidget {
  final ClientModel client;
  const ClientDetailPage({required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalles del Cliente")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(client.name[0]),
            ),
            SizedBox(height: 10),

            Text(
              "${client.name} ${client.lastName}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(client.email),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(label: Text(client.status)),
              ],
            ),

            SizedBox(height: 20),
            _info("Teléfono", client.phone),
            _info("Ciudad", client.city),
            _info("Dirección", client.address),
            if (client.company != null)
              _info("Empresa", client.company!),

            Spacer(),

            ElevatedButton(
              child: Text("Editar Cliente"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ClientFormPage(editClient: client),
                ),
              ),
            )
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
}
