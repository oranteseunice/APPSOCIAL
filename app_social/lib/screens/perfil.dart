import 'package:flutter/material.dart';
import 'home.dart';
import 'mis_horas.dart';
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
        title: const Text("Mi perfil"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFF2E4A9E),

              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              nombre,

              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              rol,

              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            _buildInfoCard(
              Icons.email,
              "Correo",
              correo,
            ),

            const SizedBox(height: 15),

            // ESTUDIANTE
            if (rol == 'estudiante') ...[

              _buildInfoCard(
                Icons.school,
                "Horas requeridas",
                "500 horas",
              ),

              const SizedBox(height: 15),

              _buildInfoCard(
                Icons.access_time,
                "Horas completadas",
                "160 horas",
              ),

            ] else ...[

              // ADMIN
              _buildInfoCard(
                Icons.admin_panel_settings,
                "Panel",
                "Administrador",
              ),

              const SizedBox(height: 15),

              _buildInfoCard(
                Icons.groups,
                "Permisos",
                "Control total del sistema",
              ),
            ],

            const SizedBox(height: 30),

            ElevatedButton.icon(

              style: ElevatedButton.styleFrom(

                backgroundColor:
                    const Color(0xFF2E4A9E),

                foregroundColor:
                    const Color(0xFFFFC107),

                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),

              onPressed: () {

                Navigator.pushAndRemoveUntil(

                  context,

                  MaterialPageRoute(
                    builder: (context) =>
                        const Login(),
                  ),

                  (route) => false,
                );
              },

              icon: const Icon(Icons.logout),

              label: const Text(
                "Cerrar sesión",
              ),
            ),

          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(

        selectedItemColor:
            const Color(0xFF2E4A9E),

        unselectedItemColor: Colors.grey,

        currentIndex: 2,

        onTap: (index) {

          // HOME
          if (index == 0) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (context) => Home(
                  rol: rol,
                  nombre: nombre,
                  correo: correo,
                ),
              ),
            );
          }

          // MIS HORAS
          if (index == 1) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (context) =>
                    MisHoras(
                  rol: rol,
                ),
              ),
            );
          }
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: "Mis horas",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    IconData icon,
    String title,
    String value,
  ) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Row(
        children: [

          Icon(
            icon,
            color: const Color(0xFF2E4A9E),
          ),

          const SizedBox(width: 16),

          Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                title,

                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                value,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

            ],
          ),

        ],
      ),
    );
  }
}