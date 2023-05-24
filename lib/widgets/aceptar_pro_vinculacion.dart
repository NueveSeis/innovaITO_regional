import 'package:flutter/material.dart';
import 'package:innova_ito/models/models.dart';
import 'package:innova_ito/theme/app_tema.dart';
import 'package:provider/provider.dart';

class AceptarProVinculacion extends StatelessWidget {
  final ProyectoModelo proyecto;
  const AceptarProVinculacion({super.key, required this.proyecto});

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(
                      color: AppTema.bluegrey700,
                      //fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  'Categoria: ${proyecto.categoria}',
                  style: TextStyle(color: AppTema.bluegrey700, fontSize: 12),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  IconButton(
                      icon: const Icon(Icons.visibility_rounded, size: 30),
                      onPressed: () {},
                      color: AppTema.bluegrey700),
                  Text(
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
                        color: AppTema.redA400, size: 30),
                    onPressed: null,
                  ),
                  //SizedBox(zi),
                  Text(
                    'Asesor',
                    style: TextStyle(
                      color: AppTema.bluegrey700,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Switch(
                    value: true,
                    onChanged: (value) => print('hola'),
                    activeColor: AppTema.pizazz,
                  ),
                  Text(
                    'Aceptar',
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
