import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'crear_usuario.dart';

class ProyeccionSocial extends StatefulWidget {
  const ProyeccionSocial({super.key});

  @override
  State<ProyeccionSocial> createState() => _ProyeccionSocialState();
}

class _ProyeccionSocialState extends State<ProyeccionSocial> {
  final supabase = Supabase.instance.client;

  List usuarios = [];

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerUsuarios();
  }

  // OBTENER USUARIOS
  Future<void> obtenerUsuarios() async {
    setState(() {
      cargando = true;
    });

    try {
      final data = await supabase
          .from('usuarios')
          .select()
          .order('id_usuario');

      setState(() {
        usuarios = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }

    setState(() {
      cargando = false;
    });
  }

  // ELIMINAR USUARIO
  Future<void> eliminarUsuario(int idUsuario) async {
    try {
      await supabase
          .from('usuarios')
          .delete()
          .eq('id_usuario', idUsuario);

      obtenerUsuarios();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario eliminado'),
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
        title: const Text('Panel Administrativo'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: cargando
            ? const Center(
                child: CircularProgressIndicator(),
              )

            : usuarios.isEmpty
                ? const Center(
                    child: Text('No hay usuarios'),
                  )

                : ListView.builder(
                    itemCount: usuarios.length,

                    itemBuilder: (context, index) {
                      final user = usuarios[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),

                        padding: const EdgeInsets.all(16),

                        decoration: BoxDecoration(
                          color: const Color(0xFF2E4A9E),
                          borderRadius: BorderRadius.circular(20),
                        ),

                        child: Row(
                          children: [

                            const CircleAvatar(
                              backgroundColor: Colors.white24,
                              child: Icon(
                                Icons.person,
                                color: Colors.yellow,
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                children: [

                                  Text(
                                    user['nombre'] ?? '',

                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    user['correo'] ?? '',

                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "Rol: ${user['rol']}",

                                    style: const TextStyle(
                                      color: Colors.white54,
                                    ),
                                  ),

                                ],
                              ),
                            ),

                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),

                              onPressed: () {

                                showDialog(
                                  context: context,

                                  builder: (context) {
                                    return AlertDialog(

                                      title: const Text(
                                        'Eliminar usuario',
                                      ),

                                      content: const Text(
                                        '¿Deseas eliminar este usuario?',
                                      ),

                                      actions: [

                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },

                                          child: const Text('Cancelar'),
                                        ),

                                        TextButton(
                                          onPressed: () {

                                            Navigator.pop(context);

                                            eliminarUsuario(
                                              user['id_usuario'],
                                            );
                                          },

                                          child: const Text('Eliminar'),
                                        ),

                                      ],
                                    );
                                  },
                                );
                              },
                            ),

                          ],
                        ),
                      );
                    },
                  ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF0B429),

        child: const Icon(Icons.add),

        onPressed: () {

          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (context) => const CrearUsuario(),
            ),

          ).then((_) {

            obtenerUsuarios();

          });
        },
      ),
    );
  }
}