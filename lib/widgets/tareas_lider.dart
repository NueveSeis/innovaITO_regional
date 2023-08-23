import 'package:flutter/material.dart';

import 'package:innova_ito/theme/app_tema.dart';

import 'package:go_router/go_router.dart';

class TareasLider extends StatelessWidget {
  final IconData? icono;
  final String texto;
  final String ruta1;

  const TareasLider({
    super.key,
    required this.icono,
    required this.texto,
    required this.ruta1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.pushNamed(ruta1);
        },
        child: Container(
          width: 100,
          height: 150, // Ajusta la altura para acomodar el icono y el texto
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Card(
            elevation: 10, // Agrega la elevación a la tarjeta
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: AppTema.primario
                    .withOpacity(0.5), // Color rojo para el borde
                width: 2, // Grosor del borde
              ),
            ),
            color: AppTema.grey100, // Color de fondo de la tarjeta
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTema.indigo50,
                  ),
                  child: Center(
                    child: Icon(
                      icono,
                      size: 30,
                      color: AppTema.bluegrey700,
                    ),
                  ),
                ),
                const SizedBox(
                    height: 10), // Agrega un espacio entre el icono y el texto
                Text(
                  texto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTema.bluegrey700),
                ),
              ],
            ),
          ),
        ));
  }
}
