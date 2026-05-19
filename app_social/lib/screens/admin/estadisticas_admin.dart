import 'package:flutter/material.dart';

import '../home.dart';
import '../perfil.dart';

class EstadisticasAdmin extends StatelessWidget {
  const EstadisticasAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E4A9E),
        title: const Text("Estadísticas"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Resumen general",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: _buildCard(
                    icon: Icons.people,
                    titulo: "Estudiantes",
                    valor: "120",
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: _buildCard(
                    icon: Icons.assignment,
                    titulo: "Actividades",
                    valor: "15",
                  ),
                ),

              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child: _buildCard(
                    icon: Icons.check_circle,
                    titulo: "Horas aprobadas",
                    valor: "560",
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: _buildCard(
                    icon: Icons.pending_actions,
                    titulo: "Pendientes",
                    valor: "8",
                  ),
                ),

              ],
            ),

            const SizedBox(height: 30),

            const Text(
              "Actividad reciente",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _buildActividad(
              icon: Icons.upload_file,
              titulo: "Pamela subió evidencia",
              subtitulo: "Hace 5 minutos",
            ),

            const SizedBox(height: 15),

            _buildActividad(
              icon: Icons.check_circle,
              titulo: "Horas aprobadas",
              subtitulo: "Carlos completó 20 horas",
            ),

            const SizedBox(height: 15),

            _buildActividad(
              icon: Icons.person_add,
              titulo: "Nuevo estudiante registrado",
              subtitulo: "Eunice se registró hoy",
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(

        selectedItemColor: const Color(0xFF2E4A9E),
        unselectedItemColor: Colors.grey,
        currentIndex: 1,

        onTap: (index) {

          // INICIO
          if (index == 0) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (context) => Home(
                  rol: 'admin',
                  nombre: 'Admin',
                  correo: '',
                ),
              ),
            );
          }

          // ESTADÍSTICAS
          if (index == 1) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (context) =>
                    const EstadisticasAdmin(),
              ),
            );
          }

          // PERFIL
          if (index == 2) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (context) => Perfil(
                  rol: 'admin',
                  nombre: 'Admin',
                  correo: '',
                ),
              ),
            );
          }
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Estadísticas',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String titulo,
    required String valor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            size: 40,
            color: const Color(0xFF2E4A9E),
          ),

          const SizedBox(height: 10),

          Text(
            valor,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            titulo,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActividad({
    required IconData icon,
    required String titulo,
    required String subtitulo,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: const Color(0xFF2E4A9E),
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [

          CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(
              icon,
              color: const Color(0xFFFFC107),
            ),
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                titulo,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitulo,
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}