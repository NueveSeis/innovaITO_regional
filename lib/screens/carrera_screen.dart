import 'package:flutter/material.dart';
import 'package:innova_ito/theme/cambiar_tema.dart';
import 'package:innova_ito/widgets/widgets.dart';

class CarreraScreen extends StatelessWidget {
  const CarreraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Fondo(
          tituloPantalla: 'Carreras',
          fontSize: 20,
          widget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_circle_outline_rounded),
                        Text(
                          '  Añadir carrera',
                          style: TextStyle(
                              color: CambiarTema.grey100, fontSize: 25),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'agregar_carrera');
                    },
                  ),
                ),
                SingleChildScrollView(
                  child: Column(children: const [
                    TarjetaCarrera(
                        nombreCarrera:
                            'Ingenieria en sistemas computacionales'),
                    TarjetaCarrera(nombreCarrera: 'Ingenieria Quimica'),
                    TarjetaCarrera(
                        nombreCarrera:
                            'Ingenieria en Tecnologías de la Información y Comunicaciones Ingenieria en Tecnologías de la Información y Comunicaciones'),
                    TarjetaCarrera(
                        nombreCarrera:
                            'Ingenieria en Tecnologías de la Información y Comunicaciones'),
                    TarjetaCarrera(
                        nombreCarrera:
                            'Ingenieria en sistemas computacionales'),
                    TarjetaCarrera(nombreCarrera: 'Ingenieria Quimica'),
                    TarjetaCarrera(nombreCarrera: 'Ingenieria Civil'),
                    TarjetaCarrera(
                        nombreCarrera: 'Ingenieria en gestion empresarial'),
                    TarjetaCarrera(
                        nombreCarrera:
                            'Ingenieria en sistemas computacionales'),
                    TarjetaCarrera(nombreCarrera: 'Ingenieria Quimica'),
                    TarjetaCarrera(nombreCarrera: 'Ingenieria Civil'),
                    TarjetaCarrera(
                        nombreCarrera: 'Ingenieria en gestion empresarial'),
                  ]),
                )
              ],
            ),
          )),
    );
  }
}
