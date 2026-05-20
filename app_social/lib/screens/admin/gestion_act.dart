import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// IMPORTAR PANTALLA EDITAR
import 'publicar_actividad.dart';

// IMPORTAR CARD
import '../../widgets/card_actividad.dart';

// PANTALLA GESTIONAR ACTIVIDADES
class GestionarActividades extends StatefulWidget {

  const GestionarActividades({
    super.key,
  });

  @override
  State<GestionarActividades> createState() =>
      _GestionarActividadesState();
}

class _GestionarActividadesState
    extends State<GestionarActividades> {

  // INSTANCIA SUPABASE
  final supabase =
      Supabase.instance.client;

  // LISTA ORIGINAL
  List actividades = [];

  // LISTA FILTRADA
  List actividadesFiltradas = [];

  // CONTROLADOR BUSCADOR
  final buscarController =
      TextEditingController();

  // CONTROL CARGA
  bool cargando = true;

  @override
  void initState() {

    super.initState();

    obtenerActividades();
  }

  // OBTENER ACTIVIDADES
  Future<void> obtenerActividades() async {

    try {

      final response = await supabase

          .from('actividades')

          .select();

      setState(() {

        actividades = response;

        actividadesFiltradas =
            response;

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

  // BUSCAR ACTIVIDAD
  void buscarActividad(
    String texto,
  ) {

    final resultado =
        actividades.where((actividad) {

      final titulo =
          actividad['titulo']
              .toString()
              .toLowerCase();

      return titulo.contains(
        texto.toLowerCase(),
      );

    }).toList();

    setState(() {

      actividadesFiltradas =
          resultado;
    });
  }

  // ELIMINAR ACTIVIDAD
  Future<void> eliminarActividad(
    int id,
  ) async {

    try {

      await supabase

          .from('actividades')

          .delete()

          .eq(
            'id_actividad',
            id,
          );

      // RECARGAR ACTIVIDADES
      obtenerActividades();

      ScaffoldMessenger.of(context)

          .showSnackBar(

        const SnackBar(

          content: Text(
            'Actividad eliminada',
          ),
        ),
      );

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

  // CONFIRMAR ELIMINACIÓN
  void confirmarEliminar(
    int id,
  ) {

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text(
            'Eliminar actividad',
          ),

          content: const Text(
            '¿Deseas eliminar esta actividad?',
          ),

          actions: [

            // CANCELAR
            TextButton(

              onPressed: () {

                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                'Cancelar',
              ),
            ),

            // ELIMINAR
            ElevatedButton(

              style:
                  ElevatedButton.styleFrom(

                backgroundColor:
                    Colors.red,
              ),

              onPressed: () {

                Navigator.pop(
                  context,
                );

                eliminarActividad(
                  id,
                );
              },

              child: const Text(
                'Eliminar',
              ),
            ),
          ],
        );
      },
    );
  }

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

        title: const Text(
          'Gestionar actividades',
        ),
      ),

      body: Column(

        children: [

          const SizedBox(
            height: 20,
          ),

          // BUSCADOR
          Padding(

            padding:
                const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            child: TextField(

              controller:
                  buscarController,

              onChanged:
                  buscarActividad,

              decoration: InputDecoration(

                hintText:
                    'Buscar actividad',

                prefixIcon:
                    const Icon(
                  Icons.search,
                ),

                filled: true,

                fillColor:
                    Colors.white,

                border:
                    OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          // LOADING
          cargando

              ? const Expanded(

                  child: Center(

                    child:
                        CircularProgressIndicator(),
                  ),
                )

              // EMPTY STATE
              : actividadesFiltradas
                      .isEmpty

                  ? Expanded(

                      child: Center(

                        child: Column(

                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,

                          children: [

                            Icon(

                              Icons.event_busy,

                              size: 90,

                              color:
                                  Colors.grey
                                      .shade400,
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            Text(

                              'No hay actividades',

                              style: TextStyle(

                                fontSize: 18,

                                color:
                                    Colors.grey
                                        .shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )

                  // LISTA ACTIVIDADES
                  : Expanded(

                      child:
                          ListView.builder(

                        padding:
                            const EdgeInsets.all(
                          20,
                        ),

                        itemCount:
                            actividadesFiltradas
                                .length,

                        itemBuilder:
                            (context, index) {

                          final actividad =
                              actividadesFiltradas[
                                  index];

                          // CARD ACTIVIDAD
                          return CardActividad(

                            actividad:
                                actividad,

                            onEditar: () {

                              Navigator.push(

                                context,

                                MaterialPageRoute(

                                  builder: (_) =>
                                      PublicarActividad(

                                    actividadEditar:
                                        actividad,
                                  ),
                                ),
                              );
                            },

                            onEliminar: () {

                              confirmarEliminar(

                                actividad[
                                    'id_actividad'],
                              );
                            },
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}