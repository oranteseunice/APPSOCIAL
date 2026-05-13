import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PublicarActividad extends StatefulWidget {
  const PublicarActividad({super.key});

  @override
  State<PublicarActividad> createState() => _PublicarActividadState();
}

class _PublicarActividadState extends State<PublicarActividad> {

  final supabase = Supabase.instance.client;

  final tituloController = TextEditingController();
  final descripcionController = TextEditingController();
  final horasController = TextEditingController();
  final lugarController = TextEditingController();

  Future<void> publicarActividad() async {

    if (
      tituloController.text.isEmpty ||
      descripcionController.text.isEmpty ||
      horasController.text.isEmpty ||
      lugarController.text.isEmpty
    ) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Completa todos los campos'),
        ),
      );

      return;
    }

    try {

      await supabase.from('actividades').insert({

        'titulo': tituloController.text.trim(),

        'descripcion': descripcionController.text.trim(),

        'horas': int.parse(
          horasController.text.trim(),
        ),

        'lugar': lugarController.text.trim(),

      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Actividad publicada'),
        ),
      );

      tituloController.clear();
      descripcionController.clear();
      horasController.clear();
      lugarController.clear();

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
        title: const Text('Publicar actividad'),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 20),

            TextField(
              controller: tituloController,

              decoration: InputDecoration(
                labelText: 'Título',

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: descripcionController,

              maxLines: 4,

              decoration: InputDecoration(
                labelText: 'Descripción',

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: horasController,

              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                labelText: 'Horas',

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: lugarController,

              decoration: InputDecoration(
                labelText: 'Lugar',

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E4A9E),

                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
              ),

              onPressed: publicarActividad,

              child: const Text(
                'Publicar',
              ),
            ),

          ],
        ),
      ),
    );
  }
}