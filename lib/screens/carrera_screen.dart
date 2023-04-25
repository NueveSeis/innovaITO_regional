import 'package:flutter/material.dart';
import 'package:innova_ito/widgets/widgets.dart';

class CarreraScreen extends StatelessWidget {
  const CarreraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Carreras',
          fontSize: 20,
          widget: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.green,
                height: 35,
                width: 250,
              ),
              SingleChildScrollView()
            ],
          )),
    );
  }
}
