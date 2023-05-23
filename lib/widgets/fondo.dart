import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:provider/provider.dart';

class Fondo extends StatelessWidget {
  final Widget widget;
  final String tituloPantalla;
  final double fontSize;
  const Fondo(
      {super.key,
      required this.tituloPantalla,
      required this.fontSize,
      required this.widget});

  @override
  Widget build(BuildContext context) {
    final temaApp = Provider.of<CambiarTema>(context);
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.only(bottom: 10),
        height: double.infinity,
        width: double.infinity,
        color: CambiarTema.primario,
        child: SafeArea(
            child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  iconSize: 45,
                  color: Colors.white,
                  onPressed: () {
                    context.pushNamed('menu_lateral');

                    //Navigator.pushNamed(context, 'menu_lateral');
                  },
                  icon: Icon(Icons.clear_all_rounded)),
              Text(
                tituloPantalla,
                style: TextStyle(color: Colors.white, fontSize: fontSize),
              ),
              IconButton(
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: () {},
                  icon: Icon(Icons.search)),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: (temaApp.temaOscuro)
                    ? CambiarTema.balticSea
                    : CambiarTema.indigo50,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: SingleChildScrollView(child: widget),
            ),
          )
        ])),
      ),
    );
  }
}
