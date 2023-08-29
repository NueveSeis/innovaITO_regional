import 'package:flutter/material.dart';

import 'package:innova_ito/theme/app_tema.dart';

class CardPosiciones extends StatelessWidget {
  final String nombreProyecto;
  final String nombreTecnologico;
  final String nombreCategoria;
  final String calificacion;
  final int posicion;
  const CardPosiciones(
      {super.key,
      required this.nombreProyecto,
      required this.nombreTecnologico,
      required this.nombreCategoria,
      required this.calificacion,
      required this.posicion});

  @override
  Widget build(BuildContext context) {
    double califica = double.parse(calificacion) / 100.0;
    double cal = double.parse(calificacion);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 10,
          top: 10,
          left: 20,
          right: 20,
        ),
        decoration: BoxDecoration(
          color: AppTema.grey100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  posicion.toString(),
                  style: const TextStyle(
                      color: AppTema.bluegrey700,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  overflow: TextOverflow.visible,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      padding: const EdgeInsets.only(right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nombreProyecto,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            overflow: TextOverflow.visible,
                          ),
                          Text(
                            nombreCategoria,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                            overflow: TextOverflow.visible,
                          ),
                          Text(
                            nombreTecnologico,
                            style: const TextStyle(
                                color: AppTema.bluegrey700,
                                fontWeight: FontWeight.normal,
                                fontSize: 13),
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          LinearProgressIndicator(
                            value: califica,
                            backgroundColor: AppTema.indigo50,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppTema.primario,
                            ),
                          ),
                          if (cal < 70.0)
                            Transform.rotate(
                              angle: -0.785398, // 45 degrees in radians
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                color: Colors.red,
                                child: Text(
                                  'No Acreditado',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  '$cal',
                  style: const TextStyle(
                      color: AppTema.bluegrey700,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
