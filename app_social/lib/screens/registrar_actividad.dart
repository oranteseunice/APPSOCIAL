import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home.dart';
import 'mis_horas.dart';
import 'perfil.dart';

class RegistrarActividad extends StatefulWidget {
  final String rol;

  const RegistrarActividad({super.key, required this.rol});

  @override
  State<RegistrarActividad> createState() => _RegistrarActividadState();
}

class _RegistrarActividadState extends State<RegistrarActividad> {
  // ARCHIVO SELECCIONADO
  File? archivoSeleccionado;

  // NOMBRE DEL ARCHIVO
  String? nombreArchivo;

  // CONTROLADOR COMENTARIO
  final TextEditingController comentarioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E4A9E),

        iconTheme: const IconThemeData(color: Colors.white),

        title: const Text(
          "Subir evidencia",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        centerTitle: true,
      ),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            // TEXTO
            const Text(
              "Sube evidencia de la actividad realizada",

              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 25),

            // CAMPO COMENTARIO
            TextField(
              controller: comentarioController,

              maxLines: 3,

              decoration: InputDecoration(
                hintText: "Comentario (opcional)",

                filled: true,
                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),

                  borderSide: const BorderSide(color: Colors.transparent),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),

                  borderSide: const BorderSide(
                    color: Color(0xFF2E4A9E),
                    width: 2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // BOTON SUBIR ARCHIVO
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,

                foregroundColor: const Color(0xFF2E4A9E),

                elevation: 2,

                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              onPressed: () async {
                // SELECCIONAR ARCHIVO
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,

                  allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg'],
                );

                // VALIDAR SI SELECCIONÓ
                if (result != null) {
                  setState(() {
                    archivoSeleccionado = File(result.files.single.path!);

                    nombreArchivo = result.files.single.name;
                  });
                }
              },

              icon: const Icon(Icons.attach_file),

              label: const Text(
                "Subir archivo",

                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 20),

            // MOSTRAR ARCHIVO
            if (archivoSeleccionado != null)
              Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf, color: Colors.red),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        "Archivo: $nombreArchivo",

                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 35),

            // BOTON ENVIAR
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E4A9E),

                foregroundColor: const Color(0xFFFFC107),

                elevation: 3,

                padding: const EdgeInsets.symmetric(
                  horizontal: 45,
                  vertical: 15,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),

              onPressed: () async {
                // VALIDAR ARCHIVO
                if (archivoSeleccionado == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Debes subir un archivo")),
                  );

                  return;
                }

                try {
                  // NOMBRE ÚNICO
                  final nombre = DateTime.now().millisecondsSinceEpoch
                      .toString();

                  // SUBIR ARCHIVO A STORAGE
                  await Supabase.instance.client.storage
                      .from('evidencias')
                      .upload(nombre, archivoSeleccionado!);

                  // OBTENER URL
                  final url = Supabase.instance.client.storage
                      .from('evidencias')
                      .getPublicUrl(nombre);

                  // GUARDAR EN TABLA
                  await Supabase.instance.client.from('evidencias').insert({
                    // USUARIO
                    'id_usuario': 2,

                    // ACTIVIDAD EXISTENTE
                    'id_actividad': 4,

                    // COMENTARIO
                    'comentario': comentarioController.text,

                    // URL ARCHIVO
                    'archivo': url,

                    // ESTADO
                    'estado': 'pendiente',
                  });

                  // MENSAJE ÉXITO
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Enviado correctamente")),
                  );
                } catch (e) {
                  // MENSAJE ERROR
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Error: $e")));
                }
              },

              child: const Text(
                "Enviar",

                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFFFC107),

        unselectedItemColor: Colors.grey,

        currentIndex: 0,

        onTap: (index) {
          // INICIO
          if (index == 0) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(
                builder: (context) =>
                    Home(rol: widget.rol, nombre: 'Usuario', correo: ''),
              ),
            );
          }

          // MIS HORAS
          if (index == 1) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(
                builder: (context) => MisHoras(rol: widget.rol),
              ),
            );
          }

          // PERFIL
          if (index == 2) {
            Navigator.pushReplacement(
              context,

              MaterialPageRoute(
                builder: (context) =>
                    Perfil(rol: widget.rol, nombre: 'Usuario', correo: ''),
              ),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),

          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: "Mis horas",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
