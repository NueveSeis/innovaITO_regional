import 'package:flutter/material.dart';

class FondoAcceso extends StatelessWidget {
  final Widget child;

  const FondoAcceso({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFFA7A1E),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SafeArea(
              child: Container(
                  width: double.infinity,
                  height: 250,
                  child: Image.asset(
                    'assets/imagenes/logo_innovaITO_blanco.png',
                  )),
            ),
            child
          ],
        ));
  }
}
