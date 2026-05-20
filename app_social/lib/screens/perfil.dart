import 'package:flutter/material.dart';

// IMPORTAR PANTALLAS
import 'home.dart';
import 'mis_horas.dart';
import 'admin/estadisticas_admin.dart';
import 'login.dart';

// PANTALLA PERFIL
class Perfil extends StatelessWidget {

  // VARIABLES DEL USUARIO
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

      // COLOR FONDO
      backgroundColor: const Color(0xFFF4F6FA),

      // APPBAR
      appBar: AppBar(

        backgroundColor:
            const Color(0xFF2E4A9E),

        title: const Text(
          'Mi perfil',
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(
              height: 10,
            ),

            // LOGO PERFIL
            ClipOval(

              child: Image.asset(

                'assets/logo.jpeg',

                width: 130,
                height: 130,

                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // NOMBRE USUARIO
            Text(

              nombre,

              style: const TextStyle(

                fontSize: 28,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            // ROL USUARIO
            Text(

              rol.toUpperCase(),

              style: TextStyle(

                color:
                    Colors.grey.shade600,

                fontSize: 16,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // CARD CORREO
            _buildInfoCard(

              icon: Icons.email,

              titulo: 'Correo',

              contenido: correo,
            ),

            const SizedBox(
              height: 18,
            ),

            // CARD PANEL
            _buildInfoCard(

              icon:
                  Icons.admin_panel_settings,

              titulo: 'Panel',

              contenido:

                  rol == 'admin'
                      ? 'Administrador'
                      : 'Estudiante',
            ),

            const SizedBox(
              height: 18,
            ),

            // CARD PERMISOS
            _buildInfoCard(

              icon: Icons.groups,

              titulo: 'Permisos',

              contenido:

                  rol == 'admin'
                      ? 'Control total del sistema'
                      : 'Acceso a actividades',
            ),

            const SizedBox(
              height: 35,
            ),

            // BOTON CERRAR SESION
            SizedBox(

              width: 230,

              child:
                  ElevatedButton.icon(

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(
                    0xFF2E4A9E,
                  ),

                  foregroundColor:
                      Colors.yellow,

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 15,
                  ),

                  shape:
                      RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(
                      35,
                    ),
                  ),
                ),

                onPressed: () {

                  // REGRESAR LOGIN
                  Navigator.pushReplacement(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                          const Login(),
                    ),
                  );
                },

                icon: const Icon(
                  Icons.logout,
                ),

                label: const Text(

                  'Cerrar sesión',

                  style: TextStyle(

                    fontWeight:
                        FontWeight.bold,

                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // MENU INFERIOR
      bottomNavigationBar:
          BottomNavigationBar(

        currentIndex: 2,

        selectedItemColor:
            const Color(0xFF2E4A9E),

        unselectedItemColor:
            Colors.grey,

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

  // WIDGET CARD INFORMACION
  Widget _buildInfoCard({

    required IconData icon,

    required String titulo,

    required String contenido,
  }) {

    return Container(

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        boxShadow: [

          BoxShadow(

            color: Colors.black12,

            blurRadius: 5,

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
          Container(

            padding:
                const EdgeInsets.all(
              12,
            ),

            decoration: BoxDecoration(

              color: const Color(
                0xFF2E4A9E,
              ).withOpacity(0.1),

              borderRadius:
                  BorderRadius.circular(
                14,
              ),
            ),

            child: Icon(

              icon,

              color:
                  const Color(
                0xFF2E4A9E,
              ),
            ),
          ),

          const SizedBox(
            width: 15,
          ),

          // TEXTOS
          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  titulo,

                  style: TextStyle(

                    color:
                        Colors.grey.shade600,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(

                  contenido,

                  style:
                      const TextStyle(

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,
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