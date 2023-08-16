import 'package:flutter/material.dart';

import 'package:innova_ito/theme/app_tema.dart';

class FondoAcceso extends StatelessWidget {
  final Widget child;

  const FondoAcceso({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTema.primario,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SafeArea(
              child: SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: Image.asset(
                    'assets/imagenes/logo_innovaITO_negro.png',
                  )),
            ),
            child
          ],
        ));
  }
}
