import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'publicar_actividad.dart';

class GestionarActividades extends StatefulWidget {
  const GestionarActividades({super.key});

  @override
  State<GestionarActividades> createState() =>
      _GestionarActividadesState();
}

class _GestionarActividadesState
    extends State<GestionarActividades> {

  final supabase = Supabase.instance.client;

  List actividades = [];

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerActividades();
  }

  Future<void> obtenerActividades() async {

    try {

      final response = await supabase
          .from('actividades')
          .select();

      setState(() {

        actividades = response;
        cargando = false;
      });

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  Future<void> eliminarActividad(int id) async {

    try {

      await supabase
          .from('actividades')
          .delete()
          .eq('id_actividad', id);

      obtenerActividades();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Actividad eliminada'),
        ),
      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(

        backgroundColor: const Color(0xFF2E4A9E),

        title: const Text(
          'Gestionar actividades',
        ),
      ),

      body: cargando

          ? const Center(
              child: CircularProgressIndicator(),
            )

          : actividades.isEmpty

              ? const Center(
                  child: Text(
                    'No hay actividades publicadas',
                  ),
                )

              : ListView.builder(

                  padding: const EdgeInsets.all(20),

                  itemCount: actividades.length,

                  itemBuilder: (context, index) {

                    final actividad = actividades[index];

                    return Container(

                      margin:
                          const EdgeInsets.only(bottom: 20),

                      padding: const EdgeInsets.all(18),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        borderRadius:
                            BorderRadius.circular(20),

                        boxShadow: [

                          BoxShadow(

                            color: Colors.black12,

                            blurRadius: 8,

                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Column(

                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(

                            actividad['titulo'] ?? '',

                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            actividad['descripcion'] ?? '',
                          ),

                          const SizedBox(height: 12),

                          Text(
                            'Horas máximas: ${actividad['horas_maximas']}',
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Categoría: ${actividad['categoria']}',
                          ),

                          const SizedBox(height: 25),

                          Row(

                            mainAxisAlignment:
                                MainAxisAlignment.end,

                            children: [

                              // BOTON EDITAR
                              SizedBox(

                                width: 110,

                                child: ElevatedButton.icon(

                                  style:
                                      ElevatedButton.styleFrom(

                                    backgroundColor:
                                        Colors.orange,

                                    foregroundColor:
                                        Colors.white,

                                    shape:
                                        RoundedRectangleBorder(

                                      borderRadius:
                                          BorderRadius.circular(
                                              20),
                                    ),
                                  ),

                                  onPressed: () {

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

                                  icon: const Icon(
                                    Icons.edit,
                                  ),

                                  label: const Text(
                                    'Editar',
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              // BOTON ELIMINAR
                              SizedBox(

                                width: 150,

                                child: ElevatedButton.icon(

                                  style:
                                      ElevatedButton.styleFrom(

                                    backgroundColor:
                                        Colors.red,

                                    foregroundColor:
                                        Colors.white,

                                    shape:
                                        RoundedRectangleBorder(

                                      borderRadius:
                                          BorderRadius.circular(
                                              20),
                                    ),
                                  ),

                                  onPressed: () {

                                    eliminarActividad(
                                      actividad[
                                          'id_actividad'],
                                    );
                                  },

                                  icon: const Icon(
                                    Icons.delete,
                                  ),

                                  label: const Text(
                                    'Eliminar',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}