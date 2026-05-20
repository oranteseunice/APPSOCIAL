import 'package:flutter/material.dart';

// CARD ACTIVIDAD
class CardActividad extends StatelessWidget {

  final Map actividad;

  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  const CardActividad({

    super.key,

    required this.actividad,
    required this.onEditar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.only(
        bottom: 20,
      ),

      padding: const EdgeInsets.all(
        18,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          20,
        ),

        boxShadow: [

          BoxShadow(

            color: Colors.black12,

            blurRadius: 8,

            offset: const Offset(
              0,
              4,
            ),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // TITULO
          Text(

            actividad['titulo'] ?? '',

            style: const TextStyle(

              fontSize: 22,

              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          // DESCRIPCIÓN
          Text(

            actividad['descripcion'] ?? '',
          ),

          const SizedBox(
            height: 12,
          ),

          // HORAS
          Text(

            'Horas máximas: ${actividad['horas_maximas']}',
          ),

          const SizedBox(
            height: 8,
          ),

          // CATEGORÍA
          Text(

            'Categoría: ${actividad['categoria']}',
          ),

          const SizedBox(
            height: 25,
          ),

          // BOTONES
          Row(

            mainAxisAlignment:
                MainAxisAlignment.end,

            children: [

              // EDITAR
              SizedBox(

                width: 120,

                child:
                    ElevatedButton.icon(

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
                        20,
                      ),
                    ),
                  ),

                  onPressed: onEditar,

                  icon: const Icon(
                    Icons.edit,
                  ),

                  label: const Text(
                    'Editar',
                  ),
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              // ELIMINAR
              SizedBox(

                width: 145,

                child:
                    ElevatedButton.icon(

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
                        20,
                      ),
                    ),
                  ),

                  onPressed: onEliminar,

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
  }
}