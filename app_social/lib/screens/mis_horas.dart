import 'package:flutter/material.dart';
import 'home.dart';
import 'perfil.dart';

class MisHoras extends StatelessWidget {
  final String rol;

  const MisHoras({super.key, required this.rol});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E4A9E),
        title: const Text("Mis horas"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),

            const Text(
              "RESUMEN DE PROGRESO",
              style: TextStyle(
                letterSpacing: 2,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            _buildCard(
              icon: Icons.assignment,
              title: "Servicio Social Obligatorio",
              subtitle: "Horas generales: 120 / 400",
            ),

            const SizedBox(height: 20),

            _buildCard(
              icon: Icons.eco,
              title: "Actividades Ecológicas",
              subtitle: "Horas ambientales: 40 / 100",
            ),

            const SizedBox(height: 30),

            _buildTotalCard(),

          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF2E4A9E),
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        onTap: (index) {

          // 🔹 HOME
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  rol: rol,
                  nombre: 'Usuario',
                  correo: '',
                ),
              ),
            );
          }

          // 🔹 PERFIL
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Perfil(
                  rol: rol,
                  nombre: 'Usuario',
                  correo: '',
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

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4D6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.orange),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(
                  subtitle,
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
    );
  }

  Widget _buildTotalCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.bar_chart, color: Colors.blue, size: 28),
          ),

          const SizedBox(width: 20),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ACUMULADO TOTAL", style: TextStyle(letterSpacing: 2)),
                SizedBox(height: 6),
                Text(
                  "Horas totales: 160",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),

          const Icon(Icons.verified, color: Colors.orange, size: 40)
        ],
      ),
    );
  }
}