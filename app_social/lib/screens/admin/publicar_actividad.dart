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
  final categoriaController = TextEditingController();

  Future<void> publicarActividad() async {

    if (
      tituloController.text.isEmpty ||
      descripcionController.text.isEmpty ||
      horasController.text.isEmpty ||
      categoriaController.text.isEmpty
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

        'horas_maximas': int.parse(
          horasController.text.trim(),
        ),

        'categoria': categoriaController.text.trim(),

        'creador': 'Administrador',

      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Actividad publicada correctamente'),
        ),
      );

      tituloController.clear();
      descripcionController.clear();
      horasController.clear();
      categoriaController.clear();

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
                labelText: 'Horas máximas',

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: categoriaController,

              decoration: InputDecoration(
                labelText: 'Categoría',

                hintText: 'Social, ecológica, educativa...',

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