import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// IMPORTAR WIDGET CARD
import '../../widgets/card_evidencias.dart';

// PANTALLA PARA EVALUAR HORAS
class EvaluarHoras extends StatefulWidget {

  const EvaluarHoras({
    super.key,
  });

  @override
  State<EvaluarHoras> createState() =>
      _EvaluarHorasState();
}

class _EvaluarHorasState
    extends State<EvaluarHoras> {

  // INSTANCIA SUPABASE
  final supabase =
      Supabase.instance.client;

  // LISTA DE EVIDENCIAS
  List evidencias = [];

  // CONTROL DE CARGA
  bool cargando = true;

  @override
  void initState() {

    super.initState();

    // CARGAR EVIDENCIAS
    obtenerEvidencias();
  }

  // OBTENER EVIDENCIAS DESDE SUPABASE
  Future<void> obtenerEvidencias() async {

    try {

      final data = await supabase

          .from('evidencias')

          .select('''
            *,
            usuarios (
              nombre,
              correo
            ),
            actividades (
              descripcion,
              horas_maximas,
              categoria
            )
          ''')

          .order(
            'id',
            ascending: false,
          );

      setState(() {

        evidencias = data;

        cargando = false;
      });

    } catch (e) {

      setState(() {

        cargando = false;
      });

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

  // APROBAR HORAS
  Future<void> aprobarHoras(
    int id,
  ) async {

    try {

      await supabase

          .from('evidencias')

          .update({

            'estado': 'aprobado',
          })

          .eq('id', id);

      // RECARGAR EVIDENCIAS
      obtenerEvidencias();

      ScaffoldMessenger.of(context)

          .showSnackBar(

        const SnackBar(

          backgroundColor:
              Colors.green,

          content: Text(
            'Horas aprobadas',
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

  // RECHAZAR HORAS
  Future<void> rechazarHoras(
    int id,
  ) async {

    try {

      await supabase

          .from('evidencias')

          .update({

            'estado': 'rechazado',
          })

          .eq('id', id);

      // RECARGAR EVIDENCIAS
      obtenerEvidencias();

      ScaffoldMessenger.of(context)

          .showSnackBar(

        const SnackBar(

          backgroundColor:
              Colors.red,

          content: Text(
            'Horas rechazadas',
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
          'Evaluar horas',
        ),
      ),

      body: cargando

          // LOADING
          ? const Center(

              child:
                  CircularProgressIndicator(),
            )

          // SI NO HAY EVIDENCIAS
          : evidencias.isEmpty

              ? const Center(

                  child: Text(
                    'No hay evidencias',
                  ),
                )

              // LISTA DE EVIDENCIAS
              : ListView.builder(

                  padding:
                      const EdgeInsets.all(
                    20,
                  ),

                  itemCount:
                      evidencias.length,

                  itemBuilder:
                      (context, index) {

                    final evidencia =
                        evidencias[index];

                    // WIDGET CARD
                    return CardEvidencia(

                      evidencia:
                          evidencia,

                      onAprobar: () {

                        aprobarHoras(
                          evidencia['id'],
                        );
                      },

                      onRechazar: () {

                        rechazarHoras(
                          evidencia['id'],
                        );
                      },
                    );
                  },
                ),
    );
  }
}