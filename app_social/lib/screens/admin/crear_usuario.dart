import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CrearUsuario extends StatefulWidget {
  const CrearUsuario({super.key});

  @override
  State<CrearUsuario> createState() => _CrearUsuarioState();
}

class _CrearUsuarioState extends State<CrearUsuario> {
  // INSTANCIA SUPABASE
  final supabase = Supabase.instance.client;

  // CONTROLADORES
  final nombreController = TextEditingController();

  final correoController = TextEditingController();

  final passwordController = TextEditingController();

  // ROL DEFAULT
  String rolSeleccionado = 'estudiante';

  // MÉTODO CREAR USUARIO
  Future<void> crearUsuario() async {
    // OBTENER DATOS
    final nombre = nombreController.text.trim();

    final correo = correoController.text.trim().toLowerCase();

    final password = passwordController.text.trim();

    // VALIDAR CAMPOS
    if (nombre.isEmpty || correo.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos")),
      );

      return;
    }

    try {
      // REGISTRO REAL EN AUTH
      final response = await supabase.auth.signUp(
        email: correo,

        password: password,
      );

      // OBTENER USER AUTH
      final authUser = response.user;

      // VALIDAR USER
      if (authUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No se pudo crear el usuario")),
        );

        return;
      }

      // GUARDAR EN TABLA USUARIOS
      await supabase.from('usuarios').insert({
        'id_auth': authUser.id,

        'nombre': nombre,

        'correo': correo,

        'password': password,

        'rol': rolSeleccionado,
      });

      // MENSAJE ÉXITO
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario creado correctamente")),
      );

      // LIMPIAR CAMPOS
      nombreController.clear();

      correoController.clear();

      passwordController.clear();

      // REGRESAR
      Navigator.pop(context);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      // APPBAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E4A9E),

        iconTheme: const IconThemeData(color: Colors.white),

        title: const Text(
          "Crear usuario",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        centerTitle: true,
      ),

      // BODY
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: SingleChildScrollView(
          child: Column(
            children: [
              // INPUT NOMBRE
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

              // INPUT CORREO
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

              // INPUT PASSWORD
              TextField(
                controller: passwordController,

                obscureText: true,

                decoration: InputDecoration(
                  labelText: "Contraseña",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // DROPDOWN ROL
              DropdownButtonFormField(
                value: rolSeleccionado,

                items: const [
                  DropdownMenuItem(value: 'admin', child: Text('admin')),

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

              // BOTÓN GUARDAR
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 255, 193, 7),

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
