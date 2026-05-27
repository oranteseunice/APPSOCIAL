import 'package:flutter/material.dart';

class CardEvidencia extends StatelessWidget {

  final Map evidencia;

  final VoidCallback onAprobar;
  final VoidCallback onRechazar;

  const CardEvidencia({

    super.key,

    required this.evidencia,
    required this.onAprobar,
    required this.onRechazar,
  });

  // OBTENER COLOR SEGÚN ESTADO
  Color obtenerColorEstado(
    String estado,
  ) {

    if (estado == 'aprobado') {
      return Colors.green;
    }

    if (estado == 'rechazado') {
      return Colors.red;
    }

    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {

    // ESTADO ACTUAL
    final estado =
        evidencia['estado']
                ?.toString() ??
            'pendiente';

    return Container(

      margin: const EdgeInsets.only(
        bottom: 18,
      ),

      padding: const EdgeInsets.all(
        18,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(

            color: Colors.black12,

            blurRadius: 6,

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

          // ENCABEZADO
          Row(

            children: [

              // ICONO USUARIO
              CircleAvatar(

                backgroundColor:
                    const Color(
                  0xFF2E4A9E,
                ),

                child: const Icon(

                  Icons.person,

                  color: Colors.white,
                ),
              ),

              const SizedBox(
                width: 12,
              ),

              // NOMBRE
              Expanded(

                child: Text(

                  evidencia['usuarios']
                          ?['nombre'] ??
                      'Sin nombre',

                  style:
                      const TextStyle(

                    fontWeight:
                        FontWeight.bold,

                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 18,
          ),

          // ACTIVIDAD
          Text(

            evidencia['actividades']
                    ?['descripcion'] ??
                'Sin actividad',

            style: const TextStyle(

              fontSize: 17,

              fontWeight:
                  FontWeight.w500,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          // COMENTARIO
          Text(

            "Comentario: ${evidencia['comentario'] ?? 'Sin comentario'}",

            style: const TextStyle(

              color: Colors.black54,

              fontSize: 15,
            ),
          ),

          const SizedBox(
            height: 12,
          ),

          // HORAS
          Text(

            "Horas: ${evidencia['actividades']?['horas_maximas'] ?? 0}",

            style: const TextStyle(

              fontWeight:
                  FontWeight.w600,

              fontSize: 15,
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          // ESTADO
          Container(

            padding:
                const EdgeInsets.symmetric(

              horizontal: 14,
              vertical: 9,
            ),

            decoration: BoxDecoration(

              color:
                  obtenerColorEstado(
                estado,
              ).withOpacity(0.15),

              borderRadius:
                  BorderRadius.circular(
                30,
              ),
            ),

            child: Text(

              estado.toUpperCase(),

              style: TextStyle(

                color:
                    obtenerColorEstado(
                  estado,
                ),

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // BOTONES SOLO SI ESTÁ PENDIENTE
          if (estado == 'pendiente')

            Row(

              children: [

                // BOTÓN APROBAR
                Expanded(

                  child:
                      ElevatedButton.icon(

                    style:
                        ElevatedButton
                            .styleFrom(

                      backgroundColor:
                          Colors.green,

                      foregroundColor:
                          Colors.white,

                      padding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 14,
                      ),

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),

                    onPressed:
                        onAprobar,

                    icon: const Icon(
                      Icons.check,
                    ),

                    label: const Text(
                      'Aprobar',
                    ),
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                // BOTÓN RECHAZAR
                Expanded(

                  child:
                      ElevatedButton.icon(

                    style:
                        ElevatedButton
                            .styleFrom(

                      backgroundColor:
                          Colors.red,

                      foregroundColor:
                          Colors.white,

                      padding:
                          const EdgeInsets
                              .symmetric(
                        vertical: 14,
                      ),

                      shape:
                          RoundedRectangleBorder(

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),
                    ),

                    onPressed:
                        onRechazar,

                    icon: const Icon(
                      Icons.close,
                    ),

                    label: const Text(
                      'Rechazar',
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