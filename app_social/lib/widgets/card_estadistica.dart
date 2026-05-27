import 'package:flutter/material.dart';

// CARD ESTADÍSTICA
class CardEstadistica extends StatelessWidget {

  final IconData icon;
  final String titulo;
  final String valor;

  // NUEVO:
  // FUNCION PARA HACER CLICK
  final VoidCallback? onTap;

  const CardEstadistica({

    super.key,

    required this.icon,
    required this.titulo,
    required this.valor,

    // NUEVO
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      // ACCION AL TOCAR TARJETA
      onTap: onTap,

      child: AnimatedContainer(

        duration: const Duration(
          milliseconds: 200,
        ),

        padding:
            const EdgeInsets.all(20),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.circular(20),

          boxShadow: [

            BoxShadow(

              color: Colors.black12,

              blurRadius: 6,

              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            // ICONO
            Icon(

              icon,

              size: 40,

              color:
                  const Color(0xFF2E4A9E),
            ),

            const SizedBox(
              height: 10,
            ),

            // VALOR
            Text(

              valor,

              style: const TextStyle(

                fontSize: 28,

                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            // TITULO
            Text(

              titulo,

              textAlign:
                  TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}