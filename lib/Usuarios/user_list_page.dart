import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/client_controller.dart';
import 'UsuarioDetallePage.dart';
import 'user_form_page.dart';

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Usuario 1'),
            subtitle: Text('usuario1@mail.com'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserFormPage()),
              );
            },
          ),
          ListTile(
            title: Text('Usuario 2'),
            subtitle: Text('usuario2@mail.com'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserFormPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
