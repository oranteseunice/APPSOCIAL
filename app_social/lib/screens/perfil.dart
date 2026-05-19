import 'package:flutter/material.dart';

import 'home.dart';
import 'mis_horas.dart';
import 'admin/estadisticas_admin.dart';
import 'login.dart';

class Perfil extends StatelessWidget {

  final String rol;
  final String nombre;
  final String correo;

  const Perfil({
    super.key,
    required this.rol,
    required this.nombre,
    required this.correo,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(

        backgroundColor: const Color(0xFF2E4A9E),

        title: const Text('Mi perfil'),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 10),

            // FOTO / LOGO
            ClipOval(

              child: Image.asset(
                'assets/logo.jpeg',

                width: 130,
                height: 130,

                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Text(

              nombre,

              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(

              rol,

              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            // CORREO
            Container(

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: Row(

                children: [

                  const Icon(
                    Icons.email,
                    color: Color(0xFF2E4A9E),
                  ),

                  const SizedBox(width: 15),

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(

                          'Correo',

                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(

                          correo,

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // PANEL
            Container(

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: Row(

                children: [

                  const Icon(
                    Icons.admin_panel_settings,
                    color: Color(0xFF2E4A9E),
                  ),

                  const SizedBox(width: 15),

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(

                          'Panel',

                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(

                          rol == 'admin'
                              ? 'Administrador'
                              : 'Estudiante',

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // PERMISOS
            Container(

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(18),
              ),

              child: Row(

                children: [

                  const Icon(
                    Icons.groups,
                    color: Color(0xFF2E4A9E),
                  ),

                  const SizedBox(width: 15),

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(

                          'Permisos',

                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(

                          rol == 'admin'
                              ? 'Control total del sistema'
                              : 'Acceso a actividades',

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // BOTON CERRAR SESION
            SizedBox(

              width: 220,

              child: ElevatedButton.icon(

                style: ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(0xFF2E4A9E),

                  foregroundColor: Colors.yellow,

                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                ),

                onPressed: () {

                  Navigator.pushReplacement(

                    context,

                    MaterialPageRoute(
                      builder: (_) => const Login(),
                    ),
                  );
                },

                icon: const Icon(Icons.logout),

                label: const Text(

                  'Cerrar sesión',

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: 2,

        selectedItemColor:
            const Color(0xFF2E4A9E),

        onTap: (index) {

          // INICIO
          if (index == 0) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (_) => Home(
                  rol: rol,
                  nombre: nombre,
                  correo: correo,
                ),
              ),
            );
          }

          // ESTADISTICAS O MIS HORAS
          if (index == 1) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (_) =>

                    rol == 'admin'

                        ? const EstadisticasAdmin()

                        : MisHoras(
                            rol: rol,
                          ),
              ),
            );
          }
        },

        items: [

          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),

          BottomNavigationBarItem(

            icon: Icon(

              rol == 'admin'
                  ? Icons.bar_chart
                  : Icons.access_time,
            ),

            label:

                rol == 'admin'
                    ? 'Estadísticas'
                    : 'Mis horas',
          ),

          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}