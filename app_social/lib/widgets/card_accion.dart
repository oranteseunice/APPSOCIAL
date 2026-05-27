import 'package:flutter/material.dart';

class CardAccion extends StatelessWidget {

  final IconData icon;
  final String titulo;
  final String subtitulo;
  final VoidCallback onTap;

  const CardAccion({

    super.key,

    required this.icon,
    required this.titulo,
    required this.subtitulo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: onTap,

      borderRadius:
          BorderRadius.circular(20),

      child: Container(

        margin:
            const EdgeInsets.only(
          bottom: 15,
        ),

        padding:
            const EdgeInsets.all(18),

        decoration: BoxDecoration(

          color:
              const Color(0xFF2E4A9E),

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

        child: Row(

          children: [

            CircleAvatar(

              radius: 26,

              backgroundColor:
                  Colors.white24,

              child: Icon(

                icon,

                color: Colors.amber,

                size: 28,
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

                      color:
                          Colors.white,

                      fontSize: 18,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(

                    subtitulo,

                    style:
                        const TextStyle(

                      color:
                          Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(

              Icons.arrow_forward_ios,

              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}