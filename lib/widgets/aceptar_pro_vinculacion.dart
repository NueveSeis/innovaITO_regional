import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:innova_ito/theme/cambiar_tema.dart';

class AceptarProVinculacion extends StatelessWidget {
  const AceptarProVinculacion({super.key});

  @override
  Widget build(BuildContext context) {
    final temaApp = Provider.of<CambiarTema>(context);

    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      elevation: 10,
      child: Container(
        // width: 350,
        //height: 100,
        padding: EdgeInsets.only(bottom: 10, top: 10),
        //margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          color:
              (temaApp.temaOscuro) ? CambiarTema.emperor : CambiarTema.grey100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Nieves inalámbricas',
            style: TextStyle(
              color:
                  (temaApp.temaOscuro) ? Colors.white : CambiarTema.bluegrey700,
            ),
          ),
          Text(
            'Categoria: Industria creativa',
            style: TextStyle(
              color:
                  (temaApp.temaOscuro) ? Colors.white : CambiarTema.bluegrey700,
            ),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  IconButton(
                      icon: const Icon(Icons.visibility_rounded, size: 30),
                      onPressed: () {},
                      color: (temaApp.temaOscuro)
                          ? Colors.white
                          : CambiarTema.bluegrey700),
                  Text(
                    'Visualizar',
                    style: TextStyle(
                      color: (temaApp.temaOscuro)
                          ? Colors.white
                          : CambiarTema.bluegrey700,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Icon(Icons.trip_origin_rounded, color: Colors.red, size: 30),
                  //SizedBox(zi),
                  Text(
                    'Asesor',
                    style: TextStyle(
                      color: (temaApp.temaOscuro)
                          ? Colors.white
                          : CambiarTema.bluegrey700,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Switch(
                    value: true,
                    onChanged: (value) => print('hola'),
                    activeColor: CambiarTema.pizazz,
                  ),
                  Text(
                    'Aceptar',
                    style: TextStyle(
                      color: (temaApp.temaOscuro)
                          ? Colors.white
                          : CambiarTema.bluegrey700,
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
