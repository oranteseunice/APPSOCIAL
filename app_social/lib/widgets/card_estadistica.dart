import 'package:flutter/material.dart';

// CARD ESTADÍSTICA
class CardEstadistica extends StatelessWidget {

  final IconData icon;
  final String titulo;
  final String valor;

  const CardEstadistica({

    super.key,

    required this.icon,
    required this.titulo,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

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

        children: [

          Icon(

            icon,

            size: 40,

            color:
                const Color(0xFF2E4A9E),
          ),

          const SizedBox(
            height: 10,
          ),

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

          Text(

            titulo,

            textAlign:
                TextAlign.center,
          ),
        ],
      ),
    );
  }
}