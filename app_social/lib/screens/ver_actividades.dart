import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// IMPORTAR PANTALLAS
import 'home.dart';
import 'mis_horas.dart';
import 'perfil.dart';

// PANTALLA VER ACTIVIDADES
class VerActividades extends StatefulWidget {
  // ROL DEL USUARIO
  final String rol;
  final int? idUsuario;

  const VerActividades({super.key, required this.rol, this.idUsuario});

  @override
  State<VerActividades> createState() => _VerActividadesState();
}

class _VerActividadesState extends State<VerActividades> {
  // INSTANCIA SUPABASE
  final supabase = Supabase.instance.client;

  // LISTA ACTIVIDADES
  List actividades = [];

  // LISTA FILTRADA
  List actividadesFiltradas = [];

  // CONTROLADOR BUSCADOR
  final buscarController = TextEditingController();

  // CONTROL LOADING
  bool cargando = true;

  @override
  void initState() {
    super.initState();

    // OBTENER ACTIVIDADES
    obtenerActividades();
  }

  // OBTENER ACTIVIDADES DESDE SUPABASE
  Future<void> obtenerActividades() async {
    try {
      final response = await supabase
          .from('actividades')
          .select()
          .order('id_actividad');

      setState(() {
        actividades = response;

        actividadesFiltradas = response;

        cargando = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));

      setState(() {
        cargando = false;
      });
    }
  }

  // BUSCAR ACTIVIDAD
  void buscarActividad(String texto) {
    final resultado = actividades.where((actividad) {
      final titulo = actividad['titulo'].toString().toLowerCase();

      return titulo.contains(texto.toLowerCase());
    }).toList();

    setState(() {
      actividadesFiltradas = resultado;
    });
  }

  // OBTENER ICONO SEGÚN CATEGORÍA
  IconData obtenerIcono(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'ambiental':
        return Icons.eco;

      case 'limpieza':
        return Icons.cleaning_services;

      case 'educativa':
        return Icons.school;

      case 'social':
        return Icons.people;

      default:
        return Icons.volunteer_activism;
    }
  }

  // OBTENER COLOR SEGÚN CATEGORÍA
  Color obtenerColor(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'ambiental':
        return Colors.green;

      case 'educativa':
        return Colors.blue;

      case 'social':
        return Colors.orange;

      default:
        return const Color(0xFF2E4A9E);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // COLOR FONDO
      backgroundColor: const Color(0xFFF4F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF2E4A9E),

        iconTheme: const IconThemeData(color: Colors.white),

        title: const Text(
          'Actividades',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),

        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 20),

          // BUSCADOR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: TextField(
              controller: buscarController,

              onChanged: buscarActividad,

              decoration: InputDecoration(
                hintText: 'Buscar actividad',

                prefixIcon: const Icon(Icons.search),

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          // LOADING
          cargando
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              // EMPTY STATE
              : actividadesFiltradas.isEmpty
              ? Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(
                          Icons.event_busy,

                          size: 90,

                          color: Colors.grey.shade400,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'No hay actividades disponibles',

                          style: TextStyle(
                            fontSize: 18,

                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              // LISTA
              : Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),

                    itemCount: actividadesFiltradas.length,

                    itemBuilder: (context, index) {
                      final actividad = actividadesFiltradas[index];

                      final categoria = actividad['categoria'] ?? '';

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 18),

                        child: _buildCard(
                          obtenerIcono(categoria),

                          actividad['titulo'] ?? '',

                          actividad['descripcion'] ?? '',

                          '${actividad['horas_maximas']} horas',

                          categoria,
                          actividad['id_actividad'],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF2E4A9E),

        unselectedItemColor: Colors.grey,

        currentIndex: 0,

        onTap: (index) {
          // HOME
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

  // CARD ACTIVIDAD
  Widget _buildCard(
    IconData icon,
    String title,
    String descripcion,
    String horas,
    String categoria,
    int idActividad,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,

            blurRadius: 6,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // ICONO + CATEGORIA
          Row(
            children: [
              CircleAvatar(
                backgroundColor: obtenerColor(categoria),

                child: Icon(icon, color: Colors.white),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  categoria,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,

                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // TITULO
          Text(
            title,

            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          // DESCRIPCIÓN
          Text(descripcion, style: TextStyle(color: Colors.grey.shade700)),

          const SizedBox(height: 15),

          // HORAS
          Row(
            children: [
              const Icon(Icons.access_time, size: 20),

              const SizedBox(width: 8),

              Text(horas, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),

          const SizedBox(height: 20),

          // BOTON INSCRIPCIÓN
          SizedBox(
            width: double.infinity,

            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E4A9E),

                foregroundColor: Colors.white,

                padding: const EdgeInsets.symmetric(vertical: 14),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),

              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Inscripción disponible próximamente'),
                  ),
                );
              },

              icon: const Icon(Icons.app_registration),

              label: const Text('Inscribirse'),
            ),
          ),
        ],
      ),
    );
  }
}
