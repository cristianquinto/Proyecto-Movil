import 'package:esamen/screens/recuperar.dart';
import 'package:flutter/material.dart';
import 'package:esamen/screens/home_screen.dart';
import 'package:esamen/main.dart'; // donde está tu MainApp con el BottomNavigationBar
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';


class SesionPage extends StatelessWidget {
  SesionPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logos/JRepuestos.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ================= TITLE =================
            const Text(
              'Bienvenido',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // ================= FORM =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // EMAIL
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'El correo es obligatorio';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    // PASSWORD
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'La contraseña es obligatoria';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // ================= LOGIN BUTTON =================
// ================= LOGIN BUTTON =================
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromRGBO(18, 128, 227, 1),
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      // LOGIN SIMULADO
      if (email == 'admin@jtools.com' && password == '123456') {
        // ✅ AQUÍ VA LA ÚLTIMA PARTE DE LA RECOMENDACIÓN
        context.read<AuthController>().login();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Credenciales incorrectas'),
          ),
        );
      }
    }
  },
  child: const Text(
    'Iniciar sesión',
    style: TextStyle(fontSize: 16, color: Colors.white),
  ),
),


                    const SizedBox(height: 20),

                    // ================= FORGOT PASSWORD =================
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RestorePage(),
                          ),
                        );
                      },
                      child: const Text(  
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: Color.fromRGBO(18, 128, 227, 1),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
