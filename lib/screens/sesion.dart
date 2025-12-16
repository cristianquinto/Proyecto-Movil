import 'package:flutter/material.dart';
import 'package:esamen/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SesionPage());
  }
}

class SesionPage extends StatelessWidget {
  SesionPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                "assets/images/logos/JRepuestos.jpg",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                ),
          Column(
              children: [
                const SizedBox(height: 180),
                Text(
                  'Bienvenido',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                //desde aqui comienza el formulario
                Form(
                  key: _formKey, // llave del formulario
                  //contenedor de todo el formulario
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Correo electronico',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),

                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Ingresa tu correo electrónico",
                          border: OutlineInputBorder(),
                        ),
                        // validación del campo
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El correo electrónico es obligatorio";
                          }
                          return null;
                        },
                      ),
                      Container(
                        height: 30,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Contraseña',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: "Ingresa tu contraseña",
                          border: OutlineInputBorder(),
                        ),
                        // validación del campo
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "El contraseña es obligatorio";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(
                            double.infinity,
                            50,
                          ), // ancho completo
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String email = emailController.text;
                            String password = passwordController.text;
                            // Simulación de login
                            if (email == "admin@jtools.com" && password == "123456") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const HomeScreen()),
                                );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Credenciales incorrectas")),
                                    );
                                  }
                          }
                        },
                        child: const Text(
                          "Enviar",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(child: Text("¿olvidaste tu contraseña?")),
              ]),
        ]),
        ]),
    );
  }
}
