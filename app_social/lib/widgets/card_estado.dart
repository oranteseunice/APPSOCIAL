import 'package:flutter/material.dart';

class CardEstado extends StatelessWidget {

  final IconData icon;
  final String titulo;
  final String estado;

  const CardEstado({

    super.key,

    required this.icon,
    required this.titulo,
    required this.estado,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 15,
      ),

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(

            color: Colors.black12,

            blurRadius: 5,

            offset: const Offset(
              0,
              3,
            ),
          ),
        ],
      ),

      child: Row(

        children: [

          CircleAvatar(

            radius: 24,

            backgroundColor:
                const Color(
                    0xFF2E4A9E),

            child: Icon(

              icon,

              color: Colors.white,
            ),
          ),

          const SizedBox(
            width: 18,
          ),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  titulo,

                  style:
                      const TextStyle(

                    fontSize: 17,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(

                  estado,

                  style:
                      const TextStyle(

                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}