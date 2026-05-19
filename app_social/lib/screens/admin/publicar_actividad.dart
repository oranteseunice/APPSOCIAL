import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PublicarActividad extends StatefulWidget {

  final Map? actividadEditar;

  const PublicarActividad({
    super.key,
    this.actividadEditar,
  });

  @override
  State<PublicarActividad> createState() =>
      _PublicarActividadState();
}

class _PublicarActividadState
    extends State<PublicarActividad> {

  final supabase = Supabase.instance.client;

  final tituloController = TextEditingController();
  final descripcionController =
      TextEditingController();
  final horasController = TextEditingController();
  final categoriaController =
      TextEditingController();

  @override
  void initState() {

    super.initState();

    // SI ESTAMOS EDITANDO
    if (widget.actividadEditar != null) {

      tituloController.text =
          widget.actividadEditar!['titulo'];

      descripcionController.text =
          widget.actividadEditar!['descripcion'];

      horasController.text =
          widget.actividadEditar!['horas_maximas']
              .toString();

      categoriaController.text =
          widget.actividadEditar!['categoria'];
    }
  }

  Future<void> publicarActividad() async {

    if (
      tituloController.text.isEmpty ||
      descripcionController.text.isEmpty ||
      horasController.text.isEmpty ||
      categoriaController.text.isEmpty
    ) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            'Completa todos los campos',
          ),
        ),
      );

      return;
    }

    try {

      // CREAR ACTIVIDAD
      if (widget.actividadEditar == null) {

        await supabase
            .from('actividades')
            .insert({

          'titulo':
              tituloController.text.trim(),

          'descripcion':
              descripcionController.text.trim(),

          'horas_maximas': int.parse(
            horasController.text.trim(),
          ),

          'categoria':
              categoriaController.text.trim(),

          'creador': 'Administrador',
        });

        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(
            content: Text(
              'Actividad publicada correctamente',
            ),
          ),
        );

      } else {

        // EDITAR ACTIVIDAD
        await supabase
            .from('actividades')
            .update({

          'titulo':
              tituloController.text.trim(),

          'descripcion':
              descripcionController.text.trim(),

          'horas_maximas': int.parse(
            horasController.text.trim(),
          ),

          'categoria':
              categoriaController.text.trim(),
        })

            .eq(
              'id_actividad',

              widget.actividadEditar![
                  'id_actividad'],
            );

        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(
            content: Text(
              'Actividad actualizada correctamente',
            ),
          ),
        );
      }

      Navigator.pop(context);

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

        backgroundColor:
            const Color(0xFF2E4A9E),

        title: Text(

          widget.actividadEditar == null

              ? 'Publicar actividad'

              : 'Editar actividad',
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 20),

            // TITULO
            TextField(

              controller: tituloController,

              decoration: InputDecoration(

                labelText: 'Título',

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DESCRIPCION
            TextField(

              controller:
                  descripcionController,

              maxLines: 4,

              decoration: InputDecoration(

                labelText: 'Descripción',

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // HORAS
            TextField(

              controller: horasController,

              keyboardType:
                  TextInputType.number,

              decoration: InputDecoration(

                labelText: 'Horas máximas',

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // CATEGORIA
            TextField(

              controller:
                  categoriaController,

              decoration: InputDecoration(

                labelText: 'Categoría',

                hintText:
                    'Social, ecológica, educativa...',

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(

                  borderRadius:
                      BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 35),

            // BOTON
            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(0xFF2E4A9E),

                  foregroundColor:
                      Colors.white,

                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 16,
                  ),

                  shape: RoundedRectangleBorder(

                    borderRadius:
                        BorderRadius.circular(18),
                  ),
                ),

                onPressed: publicarActividad,

                child: Text(

                  widget.actividadEditar == null

                      ? 'Publicar'

                      : 'Actualizar',

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}