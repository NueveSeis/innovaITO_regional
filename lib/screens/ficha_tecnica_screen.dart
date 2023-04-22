import 'package:flutter/material.dart';
import 'package:innova_ito/widgets/widgets.dart';

class FichaTecnicaScreen extends StatelessWidget {
  const FichaTecnicaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Fondo(
        tituloPantalla: 'Ficha tecnica',
        fontSize: 25,
        widget: Container(),
      ),
    );
  }
}
