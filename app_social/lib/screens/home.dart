import 'package:flutter/material.dart';

// IMPORTAR PANTALLAS ESTUDIANTE
import 'mis_horas.dart';
import 'perfil.dart';
import 'registrar_actividad.dart';
import 'ver_actividades.dart';

// IMPORTAR PANTALLAS ADMIN
import 'admin/publicar_actividad.dart';
import 'admin/evaluar_horas.dart';
import 'admin/proyeccion_social.dart';
import 'admin/estadisticas_admin.dart';
import 'admin/gestion_act.dart';

// PANTALLA PRINCIPAL HOME
class Home extends StatelessWidget {

  // VARIABLES USUARIO
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

      // COLOR FONDO
      backgroundColor:
          const Color(0xFFF4F6FA),

      // APPBAR
      appBar: AppBar(

        backgroundColor:
            const Color(0xFF2E4A9E),

        title: Text(

          'Bienvenido $nombre',
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(
              height: 20,
            ),

            // LOGO PRINCIPAL
            ClipOval(

              child: Image.asset(

                'assets/logo.jpeg',

                width: 130,
                height: 130,

                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // =========================
            // PANEL ESTUDIANTE
            // =========================

            if (rol != 'admin') ...[

              // VER ACTIVIDADES
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

                  'Explora actividades disponibles',
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // MIS HORAS
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

                  'Visualiza tu progreso',
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // REGISTRAR ACTIVIDAD
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

                  Icons.add_circle,

                  'Registrar actividad',

                  'Subir evidencias',
                ),
              ),
            ],

            // =========================
            // PANEL ADMINISTRADOR
            // =========================

            if (rol == 'admin') ...[

              // MENSAJE ADMIN
              Container(

                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                  16,
                ),

                decoration: BoxDecoration(

                  color:
                      Colors.orange.shade200,

                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
                ),

                child: const Row(

                  children: [

                    Icon(
                      Icons.admin_panel_settings,
                    ),

                    SizedBox(
                      width: 10,
                    ),

                    Text(

                      'Modo administrador activado',

                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

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

                  'Crear nuevas actividades',
                ),
              ),

              const SizedBox(
                height: 20,
              ),

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

                  'CRUD de actividades',
                ),
              ),

              const SizedBox(
                height: 20,
              ),

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

                  'Aprobar o rechazar evidencias',
                ),
              ),

              const SizedBox(
                height: 20,
              ),

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

                  Icons.groups,

                  'Administrar usuarios',

                  'Panel administrativo',
                ),
              ),
            ],
          ],
        ),
      ),

      // MENU INFERIOR
      bottomNavigationBar:
          BottomNavigationBar(

        selectedItemColor:
            const Color(0xFF2E4A9E),

        unselectedItemColor:
            Colors.grey,

        currentIndex: 0,

        onTap: (index) {

          // ESTADISTICAS O MIS HORAS
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

                builder: (context) =>
                    Perfil(

                  rol: rol,

                  nombre: nombre,

                  correo: correo,
                ),
              ),
            );
          }
        },

        items: [

          // INICIO
          const BottomNavigationBarItem(

            icon: Icon(
              Icons.home,
            ),

            label: 'Inicio',
          ),

          // ESTADISTICAS O HORAS
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

          // PERFIL
          const BottomNavigationBarItem(

            icon: Icon(
              Icons.person,
            ),

            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  // WIDGET CARD PRINCIPAL
  Widget _buildCard(

    IconData icon,

    String title,

    String subtitle,
  ) {

    return Container(

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color:
            const Color(0xFF2E4A9E),

        borderRadius:
            BorderRadius.circular(
          22,
        ),

        boxShadow: [

          BoxShadow(

            color: Colors.black12,

            blurRadius: 6,

            offset:
                const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: Row(

        children: [

          // ICONO
          CircleAvatar(

            radius: 28,

            backgroundColor:
                Colors.white24,

            child: Icon(

              icon,

              color: Colors.yellow,

              size: 28,
            ),
          ),

          const SizedBox(
            width: 18,
          ),

          // TEXTOS
          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  title,

                  style:
                      const TextStyle(

                    color: Colors.white,

                    fontWeight:
                        FontWeight.bold,

                    fontSize: 18,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(

                  subtitle,

                  style:
                      const TextStyle(

                    color:
                        Colors.white70,

                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          // ICONO FLECHA
          const Icon(

            Icons.arrow_forward_ios,

            color: Colors.white70,

            size: 18,
          ),
        ],
      ),
    );
  }
}