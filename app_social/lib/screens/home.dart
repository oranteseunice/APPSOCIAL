import 'package:flutter/material.dart';
import 'mis_horas.dart';
import 'perfil.dart';
import 'registrar_actividad.dart';
import 'ver_actividades.dart';

import 'admin/publicar_actividad.dart';
import 'admin/evaluar_horas.dart';
import 'admin/proyeccion_social.dart';
import 'admin/estadisticas_admin.dart';
import 'admin/gestion_act.dart';

class Home extends StatelessWidget {

  final String rol;
  final String nombre;
  final String correo;

  const Home({
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

        title: Text(
          'Bienvenido $nombre',
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 20),

            // LOGO REDONDO
            ClipOval(

              child: Image.asset(
                'assets/logo.jpeg',

                width: 120,
                height: 120,

                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 30),

            // =========================
            // ESTUDIANTE
            // =========================

            if (rol != 'admin') ...[

              GestureDetector(

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>
                          VerActividades(
                        rol: rol,
                      ),
                    ),
                  );
                },

                child: _buildCard(
                  Icons.search,
                  'Ver actividades',
                  'Explora proyectos',
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>
                          MisHoras(
                        rol: rol,
                      ),
                    ),
                  );
                },

                child: _buildCard(
                  Icons.access_time,
                  'Mis horas',
                  'Tu progreso',
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>
                          RegistrarActividad(
                        rol: rol,
                      ),
                    ),
                  );
                },

                child: _buildCard(
                  Icons.add,
                  'Registrar actividad',
                  'Subir evidencia',
                ),
              ),
            ],

            // =========================
            // ADMIN
            // =========================

            if (rol == 'admin') ...[

              Container(

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(

                  color: Colors.orange.shade200,

                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: const Text(

                  'Modo administrador activado',

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // PUBLICAR ACTIVIDAD
              GestureDetector(

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>
                          const PublicarActividad(),
                    ),
                  );
                },

                child: _buildCard(
                  Icons.campaign,
                  'Publicar actividad',
                  'Crear actividades',
                ),
              ),

              const SizedBox(height: 20),

              // GESTIONAR ACTIVIDADES
              GestureDetector(

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>
                          const GestionarActividades(),
                    ),
                  );
                },

                child: _buildCard(
                  Icons.list_alt,
                  'Gestionar actividades',
                  'Ver actividades publicadas',
                ),
              ),

              const SizedBox(height: 20),

              // EVALUAR HORAS
              GestureDetector(

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>
                          const EvaluarHoras(),
                    ),
                  );
                },

                child: _buildCard(
                  Icons.check_circle,
                  'Evaluar horas',
                  'Aprobar estudiantes',
                ),
              ),

              const SizedBox(height: 20),

              // ADMINISTRAR USUARIOS
              GestureDetector(

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>
                          const ProyeccionSocial(),
                    ),
                  );
                },

                child: _buildCard(
                  Icons.admin_panel_settings,
                  'Administrar usuarios',
                  'Panel administrativo',
                ),
              ),
            ],
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(

        selectedItemColor:
            const Color(0xFF2E4A9E),

        currentIndex: 0,

        onTap: (index) {

          // ESTADÍSTICAS / MIS HORAS
          if (index == 1) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (context) =>

                    rol == 'admin'

                        ? const EstadisticasAdmin()

                        : MisHoras(
                            rol: rol,
                          ),
              ),
            );
          }

          // PERFIL
          if (index == 2) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (context) => Perfil(
                  rol: rol,
                  nombre: nombre,
                  correo: correo,
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

  Widget _buildCard(
    IconData icon,
    String title,
    String subtitle,
  ) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: const Color(0xFF2E4A9E),

        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Row(

        children: [

          CircleAvatar(

            backgroundColor:
                Colors.white24,

            child: Icon(
              icon,
              color: Colors.yellow,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(

                  title,

                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(

                  subtitle,

                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}