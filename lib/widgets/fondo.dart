import 'package:flutter/material.dart';

import 'package:innova_ito/theme/app_tema.dart';

import 'package:go_router/go_router.dart';

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
    return Scaffold(
      body: Container(
        //padding: EdgeInsets.only(bottom: 10),
        height: double.infinity,
        width: double.infinity,
        color: AppTema.primario,
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
                  icon: const Icon(Icons.clear_all_rounded)),
              Text(
                tituloPantalla,
                style: TextStyle(color: Colors.white, fontSize: fontSize),
              ),
              IconButton(
                  iconSize: 40,
                  color: AppTema.primario,
                  onPressed: () {},
                  icon: const Icon(Icons.search)),
            ],
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppTema.indigo50,
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
