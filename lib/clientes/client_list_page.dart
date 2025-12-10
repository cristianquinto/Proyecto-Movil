import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../clientes/client_controller.dart';
import 'client_detail_page.dart';
import 'client_form_page.dart';

class ClientListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ClientController>(context);
    TextEditingController searchCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Clientes")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                hintText: "Buscar cliente...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => controller.notifyListeners(),
            ),
          ),

          Expanded(
            child: ListView(
              children: controller.clients
                  .where((c) => c.name
                      .toLowerCase()
                      .contains(searchCtrl.text.toLowerCase()))
                  .map(
                    (c) => ListTile(
                      leading: CircleAvatar(child: Text(c.name[0])),
                      title: Text("${c.name} ${c.lastName}"),
                      subtitle: Text(c.phone),
                      trailing: Chip(
                        label: Text(c.status),
                        backgroundColor: _statusColor(c.status),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ClientDetailPage(client: c),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ClientFormPage(),
          ),
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case "Activo": return Colors.green;
      case "Inactivo": return Colors.grey;
      case "Potencial": return Colors.blue;
      case "Bloqueado": return Colors.red;
      default: return Colors.black;
    }
  }
}
