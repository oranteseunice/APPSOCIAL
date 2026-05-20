import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../home.dart';
import '../perfil.dart';

// IMPORTAR CARD
import '../../widgets/card_estadistica.dart';

// PANTALLA ESTADÍSTICAS
class EstadisticasAdmin extends StatefulWidget {

  const EstadisticasAdmin({
    super.key,
  });

  @override
  State<EstadisticasAdmin> createState() =>
      _EstadisticasAdminState();
}

class _EstadisticasAdminState
    extends State<EstadisticasAdmin> {

  // INSTANCIA SUPABASE
  final supabase =
      Supabase.instance.client;

  // VARIABLES ESTADÍSTICAS
  int totalEstudiantes = 0;

  int totalActividades = 0;

  int horasAprobadas = 0;

  int pendientes = 0;

  // LOADING
  bool cargando = true;

  @override
  void initState() {

    super.initState();

    cargarEstadisticas();
  }

  // CARGAR DATOS
  Future<void> cargarEstadisticas() async {

    try {

      // TOTAL ESTUDIANTES
      final estudiantes = await supabase
          .from('usuarios')
          .select()
          .eq('rol', 'estudiante');

      // TOTAL ACTIVIDADES
      final actividades = await supabase
          .from('actividades')
          .select();

      // APROBADAS
      final aprobadas = await supabase
          .from('evidencias')
          .select()
          .eq('estado', 'aprobado');

      // PENDIENTES
      final pendientesDB = await supabase
          .from('evidencias')
          .select()
          .eq('estado', 'pendiente');

      setState(() {

        totalEstudiantes =
            estudiantes.length;

        totalActividades =
            actividades.length;

        horasAprobadas =
            aprobadas.length;

        pendientes =
            pendientesDB.length;

        cargando = false;
      });

    } catch (e) {

      ScaffoldMessenger.of(context)

          .showSnackBar(

        SnackBar(

          content: Text(
            'Error: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF4F6FA),

      // APPBAR
      appBar: AppBar(

        backgroundColor:
            const Color(0xFF2E4A9E),

        title: const Text(
          "Estadísticas",
        ),
      ),

      body: cargando

          // LOADING
          ? const Center(

              child:
                  CircularProgressIndicator(),
            )

          // CONTENIDO
          : SingleChildScrollView(

              padding:
                  const EdgeInsets.all(
                20,
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  // TITULO
                  const Text(

                    "Resumen general",

                    style: TextStyle(

                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // FILA 1
                  Row(

                    children: [

                      Expanded(

                        child:
                            CardEstadistica(

                          icon:
                              Icons.people,

                          titulo:
                              "Estudiantes",

                          valor:
                              totalEstudiantes
                                  .toString(),
                        ),
                      ),

                      const SizedBox(
                        width: 15,
                      ),

                      Expanded(

                        child:
                            CardEstadistica(

                          icon:
                              Icons.assignment,

                          titulo:
                              "Actividades",

                          valor:
                              totalActividades
                                  .toString(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // FILA 2
                  Row(

                    children: [

                      Expanded(

                        child:
                            CardEstadistica(

                          icon:
                              Icons.check_circle,

                          titulo:
                              "Aprobadas",

                          valor:
                              horasAprobadas
                                  .toString(),
                        ),
                      ),

                      const SizedBox(
                        width: 15,
                      ),

                      Expanded(

                        child:
                            CardEstadistica(

                          icon:
                              Icons.pending,

                          titulo:
                              "Pendientes",

                          valor:
                              pendientes
                                  .toString(),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // TITULO
                  const Text(

                    "Panel administrativo",

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // TARJETA
                  _buildActividad(

                    icon:
                        Icons.analytics,

                    titulo:
                        "Sistema conectado",

                    subtitulo:
                        "Supabase funcionando correctamente",
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  _buildActividad(

                    icon:
                        Icons.verified,

                    titulo:
                        "CRUD activo",

                    subtitulo:
                        "Actividades sincronizadas",
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  _buildActividad(

                    icon:
                        Icons.people_alt,

                    titulo:
                        "Usuarios registrados",

                    subtitulo:
                        "$totalEstudiantes estudiantes activos",
                  ),
                ],
              ),
            ),

      // BOTTOM NAVIGATION
      bottomNavigationBar:
          BottomNavigationBar(

        selectedItemColor:
            const Color(0xFF2E4A9E),

        unselectedItemColor:
            Colors.grey,

        currentIndex: 1,

        onTap: (index) {

          // INICIO
          if (index == 0) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (context) =>
                    Home(

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

                builder: (context) =>
                    Perfil(

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

            icon: Icon(
              Icons.home,
            ),

            label: 'Inicio',
          ),

          BottomNavigationBarItem(

            icon:
                Icon(Icons.bar_chart),

            label:
                'Estadísticas',
          ),

          BottomNavigationBarItem(

            icon:
                Icon(Icons.person),

            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  // TARJETAS INFERIORES
  Widget _buildActividad({

    required IconData icon,

    required String titulo,

    required String subtitulo,
  }) {

    return Container(

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color:
            const Color(0xFF2E4A9E),

        borderRadius:
            BorderRadius.circular(
          18,
        ),
      ),

      child: Row(

        children: [

          CircleAvatar(

            backgroundColor:
                Colors.white24,

            child: Icon(

              icon,

              color:
                  const Color(
                0xFFFFC107,
              ),
            ),
          ),

          const SizedBox(
            width: 15,
          ),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  titulo,

                  style:
                      const TextStyle(

                    color:
                        Colors.white,

                    fontWeight:
                        FontWeight.bold,

                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(

                  subtitulo,

                  style:
                      const TextStyle(

                    color:
                        Colors.white70,
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