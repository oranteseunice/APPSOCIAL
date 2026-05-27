import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// IMPORTAR PANTALLAS

import '../home.dart';
import '../perfil.dart';

import 'evaluar_horas.dart';
import 'proyeccion_social.dart';
import 'publicar_actividad.dart';
import 'ver_inscritos.dart';

// IMPORTAR WIDGETS

import '../../widgets/card_estadistica.dart';
import '../../widgets/card_accion.dart';
import '../../widgets/card_estado.dart';

class EstadisticasAdmin extends StatefulWidget {
  const EstadisticasAdmin({super.key});

  @override
  State<EstadisticasAdmin> createState() =>
      _EstadisticasAdminState();
}

class _EstadisticasAdminState
    extends State<EstadisticasAdmin> {

  final supabase =
      Supabase.instance.client;

  // VARIABLES

  int totalInscritos = 0;
  int totalActividades = 0;
  int aprobadas = 0;
  int pendientes = 0;

  double porcentajeAprobado = 0;

  bool cargando = true;

  // INIT

  @override
  void initState() {
    super.initState();

    cargarEstadisticas();
  }

  // CARGAR ESTADISTICAS

  Future<void> cargarEstadisticas() async {

    try {

      // INSCRITOS
      final inscritosDB =
          await supabase
              .from('inscritos')
              .select();

      // ACTIVIDADES
      final actividadesDB =
          await supabase
              .from('actividades')
              .select();

      // APROBADAS
      final aprobadasDB =
          await supabase
              .from('evidencias')
              .select()
              .eq(
                'estado',
                'aprobado',
              );

      // PENDIENTES
      final pendientesDB =
          await supabase
              .from('evidencias')
              .select()
              .eq(
                'estado',
                'pendiente',
              );

      // TOTAL EVIDENCIAS
      int total =

          (aprobadasDB as List)
              .length +

          (pendientesDB as List)
              .length;

      // PORCENTAJE
      porcentajeAprobado =
          total == 0
              ? 0
              : (aprobadasDB as List)
                      .length /
                  total;

      // ACTUALIZAR UI
      setState(() {

        totalInscritos =
            inscritosDB.length;

        totalActividades =
            actividadesDB.length;

        aprobadas =
            aprobadasDB.length;

        pendientes =
            pendientesDB.length;

        cargando = false;
      });

    } catch (e) {

      setState(() {
        cargando = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(
          content:
              Text('Error: $e'),
        ),
      );
    }
  }

  // ABRIR PANTALLAS

  void abrirPantalla(
    Widget pantalla,
  ) {

    Navigator.push(

      context,

      MaterialPageRoute(
        builder: (_) =>
            pantalla,
      ),
    );
  }

  // BUILD

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(
        0xFFF4F6FA,
      ),

      // APPBAR

      appBar: AppBar(

        backgroundColor:
            const Color(
          0xFF2E4A9E,
        ),

        title: const Text(
          'Estadísticas',
        ),

        centerTitle: true,
      ),

      // BODY

      body: cargando

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : SingleChildScrollView(

              padding:
                  const EdgeInsets.all(
                20,
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  // TITULO

                  const Text(

                    'Resumen general',

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // GRID ESTADISTICAS

                  GridView.count(

                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    crossAxisCount: 2,

                    mainAxisSpacing: 16,

                    crossAxisSpacing: 16,

                    childAspectRatio: 1.1,

                    children: [

                      // INSCRITOS
                      CardEstadistica(

                        icon:
                            Icons.people,

                        titulo:
                            'Inscritos',

                        valor:
                            '$totalInscritos',

                        onTap: () {

                          abrirPantalla(
                            const VerInscritos(),
                          );
                        },
                      ),

                      // ACTIVIDADES
                      CardEstadistica(

                        icon: Icons
                            .assignment,

                        titulo:
                            'Actividades',

                        valor:
                            '$totalActividades',

                        onTap: () {

                          abrirPantalla(
                            const ProyeccionSocial(),
                          );
                        },
                      ),

                      // APROBADAS
                      CardEstadistica(

                        icon: Icons
                            .check_circle,

                        titulo:
                            'Aprobadas',

                        valor:
                            '$aprobadas',

                        onTap: () {

                          abrirPantalla(
                            const EvaluarHoras(),
                          );
                        },
                      ),

                      // PENDIENTES
                      CardEstadistica(

                        icon:
                            Icons.pending,

                        titulo:
                            'Pendientes',

                        valor:
                            '$pendientes',

                        onTap: () {

                          abrirPantalla(
                            const EvaluarHoras(),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // PROGRESO

                  Container(

                    padding:
                        const EdgeInsets
                            .all(20),

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.white,

                      borderRadius:
                          BorderRadius
                              .circular(
                        20,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color: Colors
                              .black12,

                          blurRadius:
                              6,

                          offset:
                              const Offset(
                            0,
                            4,
                          ),
                        ),
                      ],
                    ),

                    child: Column(

                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        const Text(

                          'Progreso de aprobación',

                          style:
                              TextStyle(

                            fontSize:
                                20,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        LinearProgressIndicator(

                          value:
                              porcentajeAprobado,

                          minHeight:
                              14,

                          borderRadius:
                              BorderRadius
                                  .circular(
                            20,
                          ),

                          backgroundColor:
                              Colors.grey
                                  .shade300,

                          color:
                              const Color(
                            0xFF2E4A9E,
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Text(

                          '${(porcentajeAprobado * 100).toStringAsFixed(0)}% de evidencias aprobadas',

                          style:
                              const TextStyle(

                            fontWeight:
                                FontWeight
                                    .w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // PANEL ADMIN

                  const Text(

                    'Panel administrativo',

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // PUBLICAR ACTIVIDAD
                  _buildAccion(

                    icon:
                        Icons.add_box,

                    titulo:
                        'Publicar actividad',

                    subtitulo:
                        'Crear nuevas actividades',

                    onTap: () {

                      abrirPantalla(
                        const PublicarActividad(),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // EVALUAR
                  _buildAccion(

                    icon: Icons
                        .fact_check,

                    titulo:
                        'Evaluar evidencias',

                    subtitulo:
                        'Aprobar o rechazar horas',

                    onTap: () {

                      abrirPantalla(
                        const EvaluarHoras(),
                      );
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // PROYECCION
                  _buildAccion(

                    icon:
                        Icons.school,

                    titulo:
                        'Proyección social',

                    subtitulo:
                        'Gestionar actividades sociales',

                    onTap: () {

                      abrirPantalla(
                        const ProyeccionSocial(),
                      );
                    },
                  ),
                ],
              ),
            ),

      // MENU INFERIOR

      bottomNavigationBar:
          BottomNavigationBar(

        currentIndex: 1,

        selectedItemColor:
            const Color(
          0xFF2E4A9E,
        ),

        items: const [

          BottomNavigationBarItem(

            icon: Icon(
              Icons.home,
            ),

            label: 'Inicio',
          ),

          BottomNavigationBarItem(

            icon: Icon(
              Icons.bar_chart,
            ),

            label:
                'Estadísticas',
          ),

          BottomNavigationBarItem(

            icon: Icon(
              Icons.person,
            ),

            label: 'Perfil',
          ),
        ],

        onTap: (index) {

          // INICIO
          if (index == 0) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (_) =>
                    Home(

                  rol: 'admin',

                  nombre:
                      'Admin',

                  correo:
                      'admin@gmail.com',
                ),
              ),
            );
          }

          // PERFIL
          if (index == 2) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (_) =>
                    Perfil(

                  rol: 'admin',

                  nombre:
                      'Admin',

                  correo:
                      'admin@gmail.com',
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // CARD ACCIONES

  Widget _buildAccion({

    required IconData icon,

    required String titulo,

    required String subtitulo,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        padding:
            const EdgeInsets.all(
          18,
        ),

        decoration:
            BoxDecoration(

          color:
              const Color(
            0xFF2E4A9E,
          ),

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

            const Icon(

              Icons
                  .arrow_forward_ios,

              color:
                  Colors.white70,

              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}