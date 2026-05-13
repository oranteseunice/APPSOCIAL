import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EvaluarHoras extends StatefulWidget {
  const EvaluarHoras({super.key});

  @override
  State<EvaluarHoras> createState() => _EvaluarHorasState();
}

class _EvaluarHorasState extends State<EvaluarHoras> {

  final supabase = Supabase.instance.client;

  List evidencias = [];

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerEvidencias();
  }

  Future<void> obtenerEvidencias() async {

    try {

      final data = await supabase
          .from('evidencias')
          .select();

      setState(() {
        evidencias = data;
        cargando = false;
      });

    } catch (e) {

      setState(() {
        cargando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  Future<void> aprobarHoras(int id) async {

    try {

      await supabase
          .from('evidencias')
          .update({
            'estado': 'aprobado',
          })
          .eq('id', id);

      obtenerEvidencias();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Horas aprobadas'),
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

  Future<void> rechazarHoras(int id) async {

    try {

      await supabase
          .from('evidencias')
          .update({
            'estado': 'rechazado',
          })
          .eq('id', id);

      obtenerEvidencias();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Horas rechazadas'),
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
        title: const Text('Evaluar horas'),
      ),

      body: cargando

          ? const Center(
              child: CircularProgressIndicator(),
            )

          : evidencias.isEmpty

              ? const Center(
                  child: Text('No hay evidencias'),
                )

              : ListView.builder(

                  padding: const EdgeInsets.all(20),

                  itemCount: evidencias.length,

                  itemBuilder: (context, index) {

                    final evidencia = evidencias[index];

                    return Container(

                      margin: const EdgeInsets.only(bottom: 15),

                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Text(
                            evidencia['nombre'] ?? '',

                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            evidencia['actividad'] ?? '',
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Horas: ${evidencia['horas']}",
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Estado: ${evidencia['estado']}",
                          ),

                          const SizedBox(height: 15),

                          Row(
                            children: [

                              Expanded(
                                child: ElevatedButton(

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),

                                  onPressed: () {

                                    aprobarHoras(
                                      evidencia['id'],
                                    );
                                  },

                                  child: const Text(
                                    'Aprobar',
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: ElevatedButton(

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),

                                  onPressed: () {

                                    rechazarHoras(
                                      evidencia['id'],
                                    );
                                  },

                                  child: const Text(
                                    'Rechazar',
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