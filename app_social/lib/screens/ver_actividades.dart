import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home.dart';
import 'mis_horas.dart';
import 'perfil.dart';

class VerActividades extends StatefulWidget {
  final String rol;

  const VerActividades({
    super.key,
    required this.rol,
  });

  @override
  State<VerActividades> createState() =>
      _VerActividadesState();
}

class _VerActividadesState
    extends State<VerActividades> {

  final supabase = Supabase.instance.client;

  List actividades = [];

  bool cargando = true;

  @override
  void initState() {
    super.initState();
    obtenerActividades();
  }

  Future<void> obtenerActividades() async {

    try {

      final response = await supabase
          .from('actividades')
          .select()
          .order('id_actividad');

      setState(() {
        actividades = response;
        cargando = false;
      });

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );

      setState(() {
        cargando = false;
      });

    }
  }

  IconData obtenerIcono(String categoria) {

    switch (categoria.toLowerCase()) {

      case 'ambiental':
        return Icons.eco;

      case 'limpieza':
        return Icons.cleaning_services;

      case 'educativa':
        return Icons.school;

      default:
        return Icons.volunteer_activism;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E4A9E),
        title: const Text("Actividades"),
      ),

      body: cargando

          ? const Center(
              child: CircularProgressIndicator(),
            )

          : actividades.isEmpty

              ? const Center(
                  child: Text(
                    'No hay actividades disponibles',
                  ),
                )

              : ListView.builder(

                  padding: const EdgeInsets.all(20),

                  itemCount: actividades.length,

                  itemBuilder: (context, index) {

                    final actividad =
                        actividades[index];

                    return Padding(

                      padding: const EdgeInsets.only(
                        bottom: 15,
                      ),

                      child: _buildCard(

                        obtenerIcono(
                          actividad['categoria'] ?? '',
                        ),

                        actividad['titulo'] ?? '',

                        '${actividad['horas_maximas']} horas',

                      ),
                    );
                  },
                ),

      bottomNavigationBar: BottomNavigationBar(

        selectedItemColor:
            const Color(0xFF2E4A9E),

        unselectedItemColor: Colors.grey,

        currentIndex: 0,

        onTap: (index) {

          // HOME
          if (index == 0) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (context) => Home(

                  rol: widget.rol,

                  nombre: 'Usuario',

                  correo: '',

                ),
              ),
            );
          }

          // MIS HORAS
          if (index == 1) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (context) => MisHoras(
                  rol: widget.rol,
                ),
              ),
            );
          }

          // PERFIL
          if (index == 2) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder: (context) => Perfil(

                  rol: widget.rol,

                  nombre: 'Usuario',

                  correo: '',

                ),
              ),
            );
          }
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: "Mis horas",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Perfil",
          ),

        ],
      ),
    );
  }

  Widget _buildCard(
    IconData icon,
    String title,
    String horas,
  ) {

    return Container(

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(16),

      ),

      child: Row(
        children: [

          Icon(
            icon,
            color: const Color(0xFF2E4A9E),
          ),

          const SizedBox(width: 16),

          Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(title),

              const SizedBox(height: 4),

              Text(

                horas,

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
          )

        ],
      ),
    );
  }
}