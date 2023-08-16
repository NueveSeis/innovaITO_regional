import 'package:flutter/material.dart';

import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/theme/app_tema.dart';

class ProyectoAceptado extends StatelessWidget {
  final ProyectoModelo proyecto;

  const ProyectoAceptado({super.key, required this.proyecto});

  @override
  Widget build(BuildContext context) {
    //ProyectoModelo proyectoModelo = itemsProyecto.first;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 10,
      child: Container(
        // width: 350,
        //height: 100,
        padding: const EdgeInsets.only(bottom: 10, top: 10),
        //margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color: AppTema.grey100,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  proyecto.titulo,
                  style: const TextStyle(
                      color: AppTema.bluegrey700,
                      //fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  'Categoría: ${proyecto.categoria}',
                  style:
                      const TextStyle(color: AppTema.bluegrey700, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  IconButton(
                      icon: const Icon(Icons.visibility_rounded, size: 30),
                      onPressed: () {},
                      color: AppTema.bluegrey700),
                  const Text(
                    'Visualizar',
                    style: TextStyle(
                      color: AppTema.bluegrey700,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.trip_origin_rounded,
                        color: (proyecto.asesorCheck)
                            ? AppTema.greenS400
                            : AppTema.redA400,
                        size: 30),
                    onPressed: null,
                  ),
                  //SizedBox(zi),
                  const Text(
                    'Asesor',
                    style: TextStyle(
                      color: AppTema.bluegrey700,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.trip_origin_rounded,
                        color: (proyecto.vinculacionCheck)
                            ? AppTema.greenS400
                            : AppTema.redA400,
                        size: 30),
                    onPressed: null,
                  ),
                  const Text(
                    'Vinculación',
                    style: TextStyle(
                      color: AppTema.bluegrey700,
                    ),
                  )
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}
