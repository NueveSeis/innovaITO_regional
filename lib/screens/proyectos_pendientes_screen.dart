import 'package:flutter/material.dart';
import 'package:innova_ito/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:innova_ito/theme/cambiar_tema.dart';

class ProyectosPendientesScreen extends StatelessWidget {
  const ProyectosPendientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final temaApp = Provider.of<CambiarTema>(context);

    return Scaffold(
      //backgroundColor: CambiarTema.balticSea,
      body: Container(
        //padding: EdgeInsets.only(bottom: 10),
        height: double.infinity,
        width: double.infinity,
        color: CambiarTema.primario,
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      iconSize: 45,
                      color: Colors.white,
                      onPressed: () {},
                      icon: Icon(Icons.clear_all_rounded)),
                  Text(
                    'Proyecto',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  IconButton(
                      iconSize: 40,
                      color: Colors.white,
                      onPressed: () {},
                      icon: Icon(Icons.search)),
                ],
              ),
              //SizedBox(height: 10),
              BarraBotones(),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: CambiarTema.balticSea,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        AceptarProVinculacion(),
                        AceptarProVinculacion(),
                        AceptarProVinculacion(),
                        AceptarProVinculacion(),
                        AceptarProVinculacion(),
                        AceptarProVinculacion(),
                        AceptarProVinculacion(),
                        AceptarProVinculacion(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
