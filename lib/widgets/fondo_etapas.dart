import 'package:flutter/material.dart';

import 'package:innova_ito/theme/app_tema.dart';

class FondoEtapas extends StatelessWidget {
  final Widget child;

  const FondoEtapas({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTema.primario,
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: Image.asset(
                      'assets/imagenes/logo_innovaV2.png',
                    )),
                child,
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                    width: double.infinity,
                    height: 180,
                    child: Image.asset(
                      'assets/imagenes/logo_ITO.png',
                    )),
              ],
            ),
          ),
        ));
  }
}
