import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VerInscritos extends StatefulWidget {
  const VerInscritos({super.key});

  @override
  State<VerInscritos> createState() => _VerInscritosState();
}

class _VerInscritosState extends State<VerInscritos> {
  final supabase = Supabase.instance.client;

  List inscritos = [];

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerInscritos();
  }

  Future<void> obtenerInscritos() async {
    try {
      final data = await supabase.from('inscritos').select();

      setState(() {
        inscritos = data;
        cargando = false;
      });
    } catch (e) {
      setState(() {
        cargando = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E4A9E),

        iconTheme: const IconThemeData(color: Colors.white),

        title: const Text(
          'Ver inscritos',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: cargando
          ? const Center(child: CircularProgressIndicator())
          : inscritos.isEmpty
          ? const Center(child: Text('No hay inscritos'))
          : ListView.builder(
              padding: const EdgeInsets.all(20),

              itemCount: inscritos.length,

              itemBuilder: (context, index) {
                final inscrito = inscritos[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 15),

                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFF2E4A9E),
                        child: Icon(Icons.person, color: Colors.white),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text(
                              inscrito['nombre'] ?? '',

                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(inscrito['actividad'] ?? ''),

                            const SizedBox(height: 5),

                            Text("Horas: ${inscrito['horas']}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
