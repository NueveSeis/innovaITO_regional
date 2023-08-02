import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import 'package:innova_ito/theme/app_tema.dart';
import 'package:innova_ito/ui/input_decorations.dart';
import 'package:innova_ito/widgets/widgets.dart';

class AgregarDepartamentoScreen extends StatefulWidget {
  static const String name = 'agregar_departamento';
  const AgregarDepartamentoScreen({super.key});

  @override
  State<AgregarDepartamentoScreen> createState() =>
      _AgregarDepartamentoScreenState();
}

class _AgregarDepartamentoScreenState extends State<AgregarDepartamentoScreen> {
  bool mostrarInput = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Fondo(
            fontSize: 20,
            tituloPantalla: 'Agregar departamento',
            widget: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    'Ingrese nombre del departamento',
                    style: TextStyle(
                        color: AppTema.bluegrey700,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                  Form(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                              color: AppTema.bluegrey700,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecorations.registroLiderDecoration(
                            hintText: 'Ingrese departamento',
                            labelText: 'Departamento',
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              child: const Text(
                                'Cancelar',
                                style: TextStyle(
                                    color: AppTema.grey100, fontSize: 25),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            ElevatedButton(
                              child: const Text(
                                'Guardar',
                                style: TextStyle(
                                    color: AppTema.grey100, fontSize: 25),
                              ),
                              onPressed: () {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  title: 'Agregado correctamente',
                                  autoCloseDuration: const Duration(seconds: 7),
                                  confirmBtnText: 'Hecho',
                                  confirmBtnColor: AppTema.pizazz,
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
