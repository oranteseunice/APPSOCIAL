import 'package:flutter/material.dart';

// IMPORTAR PANTALLAS
import 'home.dart';
import 'perfil.dart';

// PANTALLA MIS HORAS
class MisHoras extends StatelessWidget {
  // ROL DEL USUARIO
  final String rol;

  const MisHoras({super.key, required this.rol});

  @override
  Widget build(BuildContext context) {
    // VARIABLES PROGRESO
    const int horasTotales = 400;

    const int horasCompletadas = 160;

    // CALCULAR PORCENTAJE
    final double progreso = horasCompletadas / horasTotales;

    return Scaffold(
      // COLOR FONDO
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E4A9E),

        iconTheme: const IconThemeData(color: Colors.white),

        title: const Text(
          "Mis horas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 10),

            // TITULO
            const Text(
              "RESUMEN DE PROGRESO",

              style: TextStyle(
                letterSpacing: 2,

                color: Colors.grey,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // CARD PRINCIPAL
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(22),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,

                    blurRadius: 6,

                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // TITULO
                  const Text(
                    "Progreso general",

                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  // TEXTO HORAS
                  Text(
                    "$horasCompletadas / $horasTotales horas",

                    style: const TextStyle(
                      fontSize: 18,

                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // BARRA PROGRESO
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),

                    child: LinearProgressIndicator(
                      value: progreso,

                      minHeight: 14,

                      backgroundColor: Colors.grey.shade300,

                      valueColor: const AlwaysStoppedAnimation(
                        Color(0xFF2E4A9E),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // PORCENTAJE
                  Text(
                    "${(progreso * 100).toInt()}% completado",

                    style: TextStyle(
                      color: Colors.grey.shade700,

                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // CARD SERVICIO SOCIAL
            _buildCard(
              icon: Icons.assignment,

              title: "Servicio Social Obligatorio",

              subtitle: "Horas generales: 120 / 400",

              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            // CARD ACTIVIDADES ECOLÓGICAS
            _buildCard(
              icon: Icons.eco,

              title: "Actividades Ecológicas",

              subtitle: "Horas ambientales: 40 / 100",

              color: Colors.green,
            ),

            const SizedBox(height: 30),

            // CARD TOTAL
            _buildTotalCard(),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF2E4A9E),

        unselectedItemColor: Colors.grey,

        currentIndex: 1,

        onTap: (index) {
          // HOME
          if (index == 0) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(
                builder: (context) =>
                    Home(rol: rol, nombre: 'Usuario', correo: ''),
              ),
            );
          }

          // PERFIL
          if (index == 2) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(
                builder: (context) =>
                    Perfil(rol: rol, nombre: 'Usuario', correo: ''),
              ),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),

          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),

            label: "Mis horas",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }

  // CARD PEQUEÑA
  Widget _buildCard({
    required IconData icon,

    required String title,

    required String subtitle,

    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,

            blurRadius: 5,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          // ICONO
          Container(
            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(
              color: color.withOpacity(0.15),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 16),

          // TEXTOS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(title, style: TextStyle(color: Colors.grey.shade700)),

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

  // CARD TOTAL HORAS
  Widget _buildTotalCard() {
    return Container(
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: const Color(0xFFFFC107),

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,

            blurRadius: 6,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          // ICONO
          Container(
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white24,

              borderRadius: BorderRadius.circular(16),
            ),

            child: const Icon(Icons.bar_chart, color: Colors.blue, size: 30),
          ),

          const SizedBox(width: 20),

          // TEXTO
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "ACUMULADO TOTAL",

                  style: TextStyle(
                    letterSpacing: 2,

                    fontWeight: FontWeight.bold,
                  ),
                ),

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

          // ICONO VERIFICADO
          const Icon(Icons.verified, color: Colors.orange, size: 40),
        ],
      ),
    );
  }
}
