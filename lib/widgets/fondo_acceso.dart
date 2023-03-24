import 'package:flutter/material.dart';

class FondoAcceso extends StatelessWidget {
  final Widget child;

  const FondoAcceso({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromRGBO(46, 45, 47, 1),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SafeArea(
              child: Container(
                  width: double.infinity,
                  height: 250,
                  child: Image.asset(
                    'assets/imagenes/logo_innovaITO.png',
                  )),
            ),
            child
          ],
        ));
  }
}
