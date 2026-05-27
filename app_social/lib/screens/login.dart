import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// IMPORTA EL BOTÓN PERSONALIZADO
import '../botones/button.dart';

// IMPORTA EL HOME
import 'home.dart';

// PANTALLA LOGIN
class Login extends StatefulWidget {

  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // CONTROLADORES DE LOS INPUTS
  final correoController = TextEditingController();
  final passwordController = TextEditingController();

  // VARIABLE PARA MOSTRAR LOADING
  bool cargando = false;

  // LIBERAR MEMORIA
  @override
  void dispose() {

    correoController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  // MÉTODO LOGIN
  Future<void> iniciarSesion() async {

    // EVITA MULTIPLES CLICKS
    if (cargando) return;

    // ACTIVA LOADING
    setState(() {
      cargando = true;
    });

    // INSTANCIA SUPABASE
    final supabase = Supabase.instance.client;

    // OBTENER DATOS INPUTS
    final correo =
        correoController.text
            .trim()
            .toLowerCase();

    final password =
        passwordController.text.trim();

    // VALIDAR CAMPOS VACÍOS
    if (correo.isEmpty || password.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            'Completa todos los campos',
          ),
        ),
      );

      setState(() {
        cargando = false;
      });

      return;
    }

    try {

      // LOGIN REAL SUPABASE AUTH
      await supabase.auth.signInWithPassword(

        email: correo,
        password: password,
      );

      // BUSCAR DATOS EN TABLA USUARIOS
      final user = await supabase
          .from('usuarios')
          .select()
          .eq('correo', correo)
          .maybeSingle();

      // VALIDAR SI EXISTE
      if (user == null) {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          const SnackBar(
            content: Text(
              'Usuario no encontrado',
            ),
          ),
        );

        setState(() {
          cargando = false;
        });

        return;
      }

      // DATOS USUARIO
      final rol =
          user['rol'] ?? 'estudiante';

      final nombre =
          user['nombre'] ?? 'Usuario';

      final correoDB =
          user['correo'] ?? '';

      // DEBUG
      print("USER: $user");

      // NAVEGAR HOME
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

    } on AuthException catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            e.message,
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

    } finally {

      // DESACTIVAR LOADING
      setState(() {
        cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // COLOR FONDO
      backgroundColor: const Color(0xFFF5F6F8),

      body: ListView(

        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
        ),

        children: [

          const SizedBox(height: 40),

          // LOGO REDONDO
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

          // TÍTULO
          const Text(

            'UCAD Servicio Social',

            textAlign: TextAlign.center,

            style: TextStyle(

              fontSize: 26,

              fontWeight: FontWeight.bold,

              color: Color.fromARGB(
                255,
                30,
                58,
                138,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // INPUT CORREO
          TextField(

            controller: correoController,

            decoration: InputDecoration(

              hintText:
                  'Correo electrónico',

              prefixIcon: const Icon(

                Icons.email,

                color: Color(0xFFF0B429),
              ),

              filled: true,

              fillColor: Colors.white,

              border: OutlineInputBorder(

                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // LABEL PASSWORD
          const Text(

            'Contraseña',

            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          // INPUT PASSWORD
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

                borderRadius:
                    BorderRadius.circular(12),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // MOSTRAR LOADER O BOTÓN
          cargando

              ? const Center(
                  child:
                      CircularProgressIndicator(),
                )

              : BotonPrincipal(

                  texto: 'Iniciar sesión',

                  onPressed: iniciarSesion,
                ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}