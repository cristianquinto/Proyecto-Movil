import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/client_model.dart';
import '../controllers/client_controller.dart';
import 'package:flutter/material.dart';
import 'user_model.dart';

class UserDetailPage extends StatelessWidget {
  final UserModel user;

  UserDetailPage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre de Usuario: ${user.userName}', style: TextStyle(fontSize: 18)),
            Text('Correo Electrónico: ${user.email}', style: TextStyle(fontSize: 18)),
            Text('Teléfono: ${user.phone}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí podrías agregar la lógica para editar o eliminar al usuario
              },
              child: Text('Editar Perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
