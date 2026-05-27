import 'package:flutter/material.dart';

class CardDashboard extends StatelessWidget {

  final IconData icono;
  final String titulo;
  final String valor;
  final Color color;
  final VoidCallback? onTap;

  const CardDashboard({
    super.key,
    required this.icono,
    required this.titulo,
    required this.valor,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius: BorderRadius.circular(20),

          boxShadow: [

            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            CircleAvatar(

              radius: 28,

              backgroundColor:
                  color.withOpacity(0.15),

              child: Icon(
                icono,
                color: color,
                size: 30,
              ),
            ),

            const SizedBox(height: 15),

            Text(

              valor,

              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(

              titulo,

              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}