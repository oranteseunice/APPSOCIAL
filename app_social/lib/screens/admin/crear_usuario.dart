import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CrearUsuario extends StatefulWidget {
  const CrearUsuario({super.key});

  @override
  State<CrearUsuario> createState() => _CrearUsuarioState();
}

class _CrearUsuarioState extends State<CrearUsuario> {

  final supabase = Supabase.instance.client;

  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final passwordController = TextEditingController();

  String rolSeleccionado = 'estudiante';

  Future<void> crearUsuario() async {

    final nombre = nombreController.text.trim();
    final correo = correoController.text.trim().toLowerCase();
    final password = passwordController.text.trim();

    if (nombre.isEmpty || correo.isEmpty || password.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Completa todos los campos"),
        ),
      );

      return;
    }

    try {

      await supabase.from('usuarios').insert({
        'nombre': nombre,
        'correo': correo,
        'password': password,
        'rol': rolSeleccionado,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usuario creado correctamente"),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        title: const Text("Crear usuario"),
        backgroundColor: const Color(0xFF2E4A9E),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller: nombreController,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: correoController,
                decoration: InputDecoration(
                  labelText: "Correo",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                obscureText: true,
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField(
                value: rolSeleccionado,

                items: const [

                  DropdownMenuItem(
                    value: 'admin',
                    child: Text('admin'),
                  ),

                  DropdownMenuItem(
                    value: 'estudiante',
                    child: Text('estudiante'),
                  ),

                ],

                onChanged: (value) {
                  setState(() {
                    rolSeleccionado = value!;
                  });
                },

                decoration: InputDecoration(
                  labelText: "Rol",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E4A9E),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),

                onPressed: crearUsuario,

                child: const Text("Guardar"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}