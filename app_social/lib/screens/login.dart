import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../botones/button.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final correoController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    correoController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF5F6F8),

      body: ListView(

        padding: const EdgeInsets.symmetric(horizontal: 20),

        children: [

          const SizedBox(height: 40),

          // LOGO CIRCULAR
          Center(
            child: ClipOval(

              child: Image.asset(
                'assets/logo.jpeg',

                width: 220,
                height: 220,

                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // TITULO
          const Text(
            'UCAD Servicio Social',

            textAlign: TextAlign.center,

            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 30, 58, 138),
            ),
          ),

          const SizedBox(height: 30),

          // CORREO
          TextField(

            controller: correoController,

            decoration: InputDecoration(

              hintText: 'Correo electrónico',

              prefixIcon: const Icon(
                Icons.email,
                color: Color(0xFFF0B429),
              ),

              filled: true,
              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // TEXTO PASSWORD
          const Text(
            'Contraseña',

            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          // PASSWORD
          TextField(

            controller: passwordController,
            obscureText: true,

            decoration: InputDecoration(

              hintText: 'Contraseña',

              prefixIcon: const Icon(
                Icons.lock,
                color: Color(0xFFF0B429),
              ),

              filled: true,
              fillColor: Colors.white,

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // BOTÓN LOGIN
          BotonPrincipal(

            texto: 'Iniciar sesión',

            onPressed: () async {

              final supabase =
                  Supabase.instance.client;

              final correo =
                  correoController.text
                      .trim()
                      .toLowerCase();

              final password =
                  passwordController.text.trim();

              // VALIDAR CAMPOS
              if (correo.isEmpty || password.isEmpty) {

                ScaffoldMessenger.of(context)
                    .showSnackBar(

                  const SnackBar(
                    content: Text(
                      'Completa todos los campos',
                    ),
                  ),
                );

                return;
              }

              try {

                // BUSCAR USUARIO
                final user = await supabase
                    .from('usuarios')
                    .select()
                    .eq('correo', correo)
                    .maybeSingle();

                print("USER: $user");

                // SI NO EXISTE
                if (user == null) {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    const SnackBar(
                      content: Text(
                        'Usuario no existe',
                      ),
                    ),
                  );

                  return;
                }

                // VALIDAR PASSWORD
                if (user['password'] != password) {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    const SnackBar(
                      content: Text(
                        'Contraseña incorrecta',
                      ),
                    ),
                  );

                  return;
                }

                // DATOS
                final rol =
                    user['rol'] ?? 'estudiante';

                final nombre =
                    user['nombre'] ?? 'Usuario';

                final correoDB =
                    user['correo'] ?? '';

                // IR AL HOME
                Navigator.pushReplacement(

                  context,

                  MaterialPageRoute(

                    builder: (context) => Home(
                      rol: rol,
                      nombre: nombre,
                      correo: correoDB,
                    ),
                  ),
                );

              } catch (e) {

                ScaffoldMessenger.of(context)
                    .showSnackBar(

                  SnackBar(
                    content: Text(
                      'Error: $e',
                    ),
                  ),
                );
              }
            },
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}