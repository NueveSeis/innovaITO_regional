import 'package:flutter/material.dart';

class ContenedorCarta extends StatelessWidget {
  final Widget child;
  const ContenedorCarta({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: _crearFiguraCarta(),
        child: child,
      ),
    );
  }

  BoxDecoration _crearFiguraCarta() => const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(70), bottomRight: Radius.circular(70)),
          boxShadow: [
            BoxShadow(
                color: Colors.black87, blurRadius: 10, offset: Offset(0, 5))
          ]);
}
